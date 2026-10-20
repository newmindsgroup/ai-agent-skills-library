#!/usr/bin/env python3
"""Return a conservative, zero-variable-cost routing decision.

Version-Timestamp: 2026-10-01 20:49:21 AST
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import sys
import tomllib


ROUTES = {
    "blocked": {"model": None, "effort": None, "speed": None, "execution": None, "fallback": None},
    "subscription-astra": {
        "model": "gpt-6-astra", "effort": "low", "speed": "standard",
        "execution": "codex --model gpt-6-astra", "fallback": "subscription-sol",
    },
    "deterministic": {
        "model": None,
        "effort": None,
        "speed": None,
        "execution": "native-tool",
        "fallback": "local-general",
    },
    "local-fast": {
        "model": "gemma4:e4b-it-q8_0",
        "effort": "low",
        "speed": "local",
        "execution": "codex --profile local-fast",
        "fallback": "local-general",
    },
    "local-general": {
        "model": "qwen3.6:35b-a3b-q4_K_M",
        "effort": "medium",
        "speed": "local",
        "execution": "codex --profile local-general",
        "fallback": "local-reasoning",
    },
    "local-code-fast": {
        "model": "devstral-small-2:24b-instruct-2512-q4_K_M",
        "effort": "medium",
        "speed": "local",
        "execution": "codex --profile local-code-fast",
        "fallback": "local-code-deep",
    },
    "local-code-deep": {
        "model": "qwen3-coder-next:q4_K_M",
        "effort": "high",
        "speed": "local",
        "execution": "codex --profile local-code-deep",
        "fallback": "subscription-terra",
    },
    "local-reasoning": {
        "model": "gpt-oss:120b",
        "effort": "high",
        "speed": "local",
        "execution": "codex --profile local-reasoning",
        "fallback": "subscription-sol",
    },
    "local-vision": {
        "model": "qwen3-vl:32b",
        "effort": "medium",
        "speed": "local",
        "execution": "codex --profile local-vision",
        "fallback": "subscription-terra",
    },
    "subscription-sol-current": {
        "model": "gpt-6.1-sol", "effort": "medium", "speed": "standard",
        "execution": "codex --model gpt-6.1-sol", "fallback": "subscription-astra",
    },
    "subscription-luna": {
        "model": "gpt-5.6-luna",
        "effort": "low",
        "speed": "standard",
        "execution": "codex --model gpt-5.6-luna",
        "fallback": "subscription-terra",
    },
    "subscription-terra": {
        "model": "gpt-5.6-terra",
        "effort": "medium",
        "speed": "standard",
        "execution": "codex --model gpt-5.6-terra",
        "fallback": "subscription-sol",
    },
    "subscription-sol": {
        "model": "gpt-5.6-sol",
        "effort": "high",
        "speed": "standard",
        "execution": "codex --model gpt-5.6-sol",
        "fallback": "claude-max-review",
    },
    "claude-app-code": {
        "model": "claude-opus-5-5", "effort": "high", "speed": "standard",
        "execution": "claude --model claude-opus-5-5 --effort high", "fallback": None,
    },
    "claude-max-review": {
        "model": "claude-opus-5",
        "effort": "medium",
        "speed": "standard",
        "execution": "codex-claude-opus",
        "fallback": "subscription-sol",
    },
}

DETERMINISTIC = r"\b(test|tests|lint|format|formatting|build|compile|grep|search files|status)\b"
BULK = r"\b(extract\w*|classif\w*|summari[sz]\w*|triage|tags?|labels?|draft variants|conver(?:t|sion)\w*)\b"
CODE = r"\b(code|repo|repository|bug|fix|refactor|function|component|test suite|pull request|diff|api|endpoint|database|schema|migration|backend|infrastructure|typescript|python|node)\b"
DEEP_CODE = r"\b(architecture|cross[- ]cutting|migration|large refactor|system design|performance)\b"
VISION = r"\b(screenshot|image|diagram|wireframe|mockup|ui|ux|visual|pdf page)\b"
HIGH_RISK = r"\b(security|legal|production|deploy|release|payment|privacy|client[- ]facing|contract)\b"
LIVE_TOOLS = r"\b(current|latest|research|browse|web|documentation|api|live|verify online)\b"
NARROW = r"\b(rewrite|short|one[- ]line|rename|simple|quick|clear|repeatable)\b"
BUGFIX = r"\b(bug|fix|broken|regression|failure|flaky|unexpected)\b"
CONTENT = r"\b(copy|content|landing page|website page|blog|article|newsletter|email campaign|email sequence|social post|caption|ad copy|video script|sales page|case study|proposal|deck)\b"
EDITING = r"\b(edit|rewrite|polish|proofread|tighten|refresh|audit|improve)\b"


def select_skills(task: str, high_risk: bool) -> tuple[str | None, str | None]:
    """Choose one implementation method and, when needed, a distinct completion gate."""
    task_lc = task.lower()
    if matches(CONTENT, task_lc) and not matches(CODE, task_lc):
        primary = "copy-editing" if matches(EDITING, task_lc) else "content-development"
        return primary, "content-quality-gate"
    if matches(BUGFIX, task_lc):
        completion = "visual-and-code-quality-gate" if matches(VISION, task_lc) else "engineering-quality-gate"
        return "systematic-debugging", completion
    if matches(VISION, task_lc):
        return "frontend-design", "visual-and-code-quality-gate"
    if matches(CODE, task_lc):
        return "test-driven-development", "engineering-quality-gate"
    if high_risk:
        return None, "verification-before-completion"
    return None, None


def matches(pattern: str, text: str) -> bool:
    return re.search(pattern, text, flags=re.IGNORECASE) is not None


def load_policy(path: Path | None) -> dict:
    if path is None:
        return {}
    if not path.is_file():
        raise ValueError("explicit project policy does not exist or is not a file")
    try:
        return tomllib.loads(path.read_text())
    except (OSError, tomllib.TOMLDecodeError) as error:
        raise ValueError(f"cannot read project policy: {error}") from error


def classify(task: str, privacy: str, risk: str, urgency: str, policy: dict) -> dict:
    development = policy.get('development', {})
    if not isinstance(development, dict) or type(development.get('quality_first', False)) is not bool:
        raise ValueError('development must be a table with boolean quality_first')
    quality_first = development.get('quality_first', False)
    signals = policy.get('task_signals', {})
    if not isinstance(signals, dict) or set(signals) - {'artifact', 'failed_attempts', 'requires_live_tools', 'touches_sensitive_surface'}:
        raise ValueError('unsupported task signals')
    artifact = signals.get('artifact', 'auto')
    if artifact not in {'auto', 'code', 'visual', 'content', 'analysis', 'mechanical'}:
        raise ValueError('unsupported artifact')
    failures = signals.get('failed_attempts', 0)
    if type(failures) is not int or not 0 <= failures <= 100:
        raise ValueError('failed_attempts must be an integer from 0 to 100')
    if type(signals.get('requires_live_tools', False)) is not bool:
        raise ValueError('requires_live_tools must be boolean')
    if type(signals.get('touches_sensitive_surface', False)) is not bool:
        raise ValueError('touches_sensitive_surface must be boolean')
    # Explicit evidence can add requirements, never erase task risk or privacy.
    hints = {'code': ' code', 'visual': ' visual', 'content': ' content'}
    task += hints.get(artifact, '')
    if quality_first and artifact in {"auto", "code"} and not (matches(CONTENT, task) and not matches(CODE, task)) and matches(r"\b(SwiftUI|Swift|UIKit|Objective[- ]C|iOS|Android|Kotlin|Java|Compose|Flutter|Dart|React Native|Expo|Kotlin Multiplatform|Capacitor|Ionic|MAUI|Next\.js|Vue|Svelte|Angular|web app|mobile app)\b", task):
        task += " code"
    task_lc = task.lower()
    project_privacy = policy.get("data_classification")
    levels = ["public", "internal", "confidential", "restricted"]
    if "data_classification" in policy and project_privacy not in levels:
        raise ValueError("unsupported project data_classification")
    if project_privacy in levels:
        privacy = max((privacy, project_privacy), key=levels.index)

    reasons: list[str] = []
    restricted = privacy in {"confidential", "restricted"}
    high_risk = risk in {"high", "critical"} or matches(HIGH_RISK, task_lc)
    high_risk = high_risk or (quality_first and matches(r"\b(authentication|authorization|permissions?|tenant isolation|PII|migrations?|login|sign[- ]in|OAuth|JWT|tokens?|sessions?|cookies?|passwords?|CORS|RLS|App Store|Play submission|Keychain|AndroidManifest|Info\.plist|entitlements?|privacy[- ]manifests?|signing|provisioning|keystore|middleware|secrets?)\b|(?<!\w)\.env(?:\b|$)", task_lc))
    high_risk = high_risk or signals.get('touches_sensitive_surface', False)
    needs_live = matches(LIVE_TOOLS, task_lc) or signals.get('requires_live_tools', False)

    mechanical = matches(DETERMINISTIC, task_lc) and not matches(r"\b(implement|create|design|fix|refactor|develop|write|analy[sz]e|explain|diagnose|review|interpret|compare)\b", task_lc)
    mechanical = mechanical and artifact in {'auto', 'mechanical'} and failures == 0
    substantial = matches(DEEP_CODE, task_lc) or matches(r"\b(complex|substantial|strategy|synthesis|design direction|design system|feature)\b", task_lc)
    substantial = substantial or (matches(VISION, task_lc) and matches(r"\b(implement|create|design|develop|fix)\b", task_lc))
    if mechanical and not (needs_live or high_risk):
        route = "deterministic"
        reasons.append("The request is primarily mechanical and should start with native tools.")
    elif restricted and matches(CODE, task_lc):
        route = "local-code-deep" if matches(DEEP_CODE, task_lc) else "local-code-fast"
        reasons.append("Sensitive repository work stays on this Mac.")
    elif restricted and matches(VISION, task_lc):
        route = "local-vision"
        reasons.append("Sensitive visual material stays on this Mac.")
    elif restricted:
        route = "local-fast" if matches(BULK, task_lc) else "local-general"
        reasons.append("Sensitive material stays local by default.")
    elif high_risk or substantial or failures:
        route = "subscription-astra"
        reasons.append("Astra leads substantial work and high-consequence decisions.")
    elif quality_first and matches(CODE, task_lc):
        route = "subscription-sol-current" if matches(NARROW, task_lc) or matches(r"\b(small|bounded|focused|routine)\b", task_lc) else "subscription-astra"
        reasons.append("Quality-first: current Sol for explicitly bounded code; Astra for broad or ambiguous code.")
    elif needs_live and not matches(CODE, task_lc):
        route = "subscription-terra"
        reasons.append("Current-source work needs a hosted tool-capable route.")
    elif matches(VISION, task_lc) and not matches(CODE, task_lc):
        route = "local-vision"
        reasons.append("A local visual pass is sufficient before using subscription capacity.")
    elif matches(CODE, task_lc):
        route = "subscription-terra" if matches(NARROW, task_lc) else "subscription-astra"
        reasons.append("Use Terra for bounded routine code and Astra for substantial implementation.")
    elif matches(CONTENT, task_lc):
        route = "subscription-terra"
        reasons.append("Public-facing content benefits from the hosted drafting and editorial route.")
    elif matches(BULK, task_lc):
        route = "local-fast"
        reasons.append("The work is bounded bulk transformation.")
    elif matches(NARROW, task_lc):
        route = "subscription-luna"
        reasons.append("The request is narrow and repeatable.")
    else:
        route = "subscription-astra"
        reasons.append("Astra Low is the starting orchestrator; select specialists for bounded work.")

    availability = policy.get("availability", {})
    if not isinstance(availability, dict) or any(type(value) is not bool for value in availability.values()):
        raise ValueError("availability must contain boolean values")
    requested_route = route
    if route == "subscription-sol-current" and not availability.get("sol_current", False):
        route = "subscription-astra"
        reasons.append("Current Sol access is unverified; use Astra until the execution path is checked.")
    if route == "subscription-astra" and availability.get("openai", True) and not availability.get("astra", True):
        if quality_first and matches(CODE, task_lc):
            route = "subscription-sol-current" if availability.get("sol_current", False) else "blocked"
        else:
            route = "subscription-sol" if high_risk or substantial or failures >= 2 or matches(CODE, task_lc) else "subscription-terra"
    if route.startswith("subscription-") and not availability.get("openai", True):
        route = ("claude-app-code" if quality_first and matches(CODE, task_lc) else "claude-max-review") if availability.get("claude", False) and not restricted else "local-code-deep" if matches(CODE, task_lc) else "local-general"
    if route.startswith("local-") and not availability.get("local", True):
        route = "blocked"
    if route != requested_route:
        reasons.append("Availability changed the route; preserve task state before continuing.")
    result = {"route": route, **ROUTES[route]}
    if quality_first and result["fallback"] == "subscription-sol":
        result["fallback"] = "subscription-sol-current" if availability.get("sol_current", False) else None
    if not availability.get("openai", True) or restricted:
        result["fallback"] = None
    if route in {"subscription-astra", "subscription-sol-current", "claude-max-review"} and high_risk:
        result["effort"] = "high"
    elif route == "subscription-astra" and failures:
        result['effort'] = 'high' if failures >= 2 else 'medium'
        reasons.append('Documented failed attempts warrant additional reasoning, not automatic replay.')
    elif route == 'subscription-astra' and quality_first and matches(CODE, task_lc):
        result['effort'] = 'medium'
        reasons.append('The project selects quality-first app development; Medium is provisional until measured.')
    if failures and route != "subscription-astra":
        reasons.append("Documented failed attempts retain the substitute route effort; no automatic replay.")
    if result["fallback"] == "subscription-astra" and not availability.get("astra", True):
        result["fallback"] = None
    if result["fallback"] == "claude-max-review" and not availability.get("claude", False):
        result["fallback"] = None
    if result["fallback"] and result["fallback"].startswith("local-") and not availability.get("local", True):
        result["fallback"] = None
    result["quality_escalation"] = ("subscription-astra" if availability.get("astra", True) else "subscription-sol") if route in {"subscription-luna", "subscription-terra"} else None
    result["capacity_fallback"] = "Claude Max if approved and available, otherwise a suitable local model; never another OpenAI model for a shared quota failure"
    result["retry_limit"] = 0
    result["requires_handoff"] = route != requested_route
    result["availability_source"] = "caller-declared; verify authentication and capacity before launch"
    result["privacy"] = privacy
    result["risk"] = risk
    result["openrouter"] = "not automatic"
    result["data_boundary"] = "no execution" if route == "blocked" else "local only" if restricted or route.startswith("local") or route == "deterministic" else "approved subscription only"
    if route == "blocked":
        result["capacity_fallback"] = None
        result["stop_reason"] = "No suitable approved capacity is available."
    result["re_evaluate_when"] = "scope expands, evidence conflicts, checks fail, live tools become necessary, or final risk increases"
    result["rationale"] = " ".join(reasons)
    primary_skill, completion_skill = select_skills(task, high_risk)
    if artifact == "analysis" and not matches(r"\b(implement|create|develop|write|fix|refactor)\b", task_lc):
        primary_skill = None
    result["primary_skill"] = primary_skill or "none required"
    result["completion_skill"] = completion_skill or "verification appropriate to the task"
    result["fast_mode"] = "off" if urgency != "urgent" else "ask before enabling"
    if restricted and needs_live:
        result["external_data_gate"] = "Approval required before sending restricted material to any hosted provider."
    if high_risk:
        result["final_gate"] = "Independent Astra or Claude Max review plus real checks. Restricted data requires an approved reviewer or remains local."
    visual = matches(VISION, task_lc) or matches(r"\b(design system|user experience|user interface)\b", task_lc)
    review_required = route != "deterministic" and (matches(CODE, task_lc) or visual or high_risk or substantial)
    premium_review = failures >= 2 or matches(DEEP_CODE, task_lc) or matches(r"\b(major|complex|persistent|repeated|two failed|design direction)\b", task_lc)
    fable_review = premium_review or substantial or high_risk
    result["review_gate"] = {
        "required": review_required,
        "max_calls_per_phase": 2,
        "deduplication": "same milestone, phase and evidence: do not request another review",
        "preferred_model": "claude-opus-5-5" if quality_first and matches(CODE, task_lc) else "claude-fable-5-1" if fable_review else "claude-opus-5",
        "effort": "high" if premium_review or high_risk else "medium",
        "phase": "approach and completed milestone" if premium_review else "after checks at completed milestone",
        "status": "not_required" if not review_required else "pending_data_approval" if restricted else "pending_review",
        "fallback": "Current Opus unavailable or stale billing: review pending; only an explicitly approved substitute under the same milestone budget" if quality_first and matches(CODE, task_lc) else "Opus 5 with an explicit substitution record if Fable access or included usage is unverified; pending if neither is available",
        "evidence": ["requirements", "relevant changes", "checks and results"] + (["screenshots", "desktop and mobile", "changed interaction states", "design references"] if visual else []),
        "acceptance": "Implementer resolves valid findings and reruns checks; a model response is not approval",
    }
    return result


def stage_handoff(decision: dict, stage: str, entry: Path | None) -> dict:
    """Bind an advisory route to file identity without loading executable instructions."""
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9._-]{0,79}", stage):
        raise ValueError("stage must be a short identifier")
    skill = None
    if entry is not None:
        try:
            resolved = entry.resolve(strict=True)
            if resolved.name != "SKILL.md" or not resolved.is_file():
                raise ValueError("skill entry must be an existing SKILL.md file")
            with resolved.open("rb") as source:
                raw = source.read(1_048_577)
            if len(raw) > 1_048_576:
                raise ValueError("skill entry exceeds the one MiB inspection limit")
            content = raw.decode("utf-8")
        except (OSError, UnicodeError) as error:
            raise ValueError("skill entry is missing or unreadable") from error
        front = re.match(r"\A---\r?\n(.*?)\r?\n---(?:\r?\n|$)", content, re.S)
        names = re.findall(r"^name: *([A-Za-z0-9][A-Za-z0-9._:-]{0,127}) *$", front[1], re.M) if front else []
        if len(names) != 1:
            raise ValueError("skill entry needs one plain frontmatter name")
        skill = {"name": names[0], "path": str(resolved), "sha256": hashlib.sha256(raw).hexdigest(),
                 "status": "identity checked; relevance, full reading and trust require agent verification"}
        decision["suggested_primary_skill"] = decision["primary_skill"]
        decision["primary_skill"] = names[0]
    return {"stage": stage, "skill": skill, "status": "recommendation only",
            "actual_model": "unverified", "model_switched": False, "runtime_verification": "none",
            "before_execution": ["Recheck hash before use; confirm skill relevance, read full instructions and resolve input holds",
                                 "Verify actual model, tools, capacity and approved data destination",
                                 "Record acceptance checks and a distinct completion gate",
                                 "Reassess on the next stage or a material change; preserve partial actions"],
            "limitation": "No model launch, permission grant, skill execution or universal best-model ranking"}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--task", required=True)
    parser.add_argument("--privacy", choices=["public", "internal", "confidential", "restricted"], default="internal")
    parser.add_argument("--risk", choices=["low", "medium", "high", "critical"], default="medium")
    parser.add_argument("--urgency", choices=["normal", "urgent"], default="normal")
    parser.add_argument("--project-policy", type=Path)
    parser.add_argument("--openai-unavailable", action="store_true", help="shared quota exhausted or provider unavailable")
    parser.add_argument("--astra-unavailable", action="store_true")
    parser.add_argument("--claude-available", action="store_true", help="approved Claude subscription is available for this task")
    parser.add_argument("--local-unavailable", action="store_true")
    parser.add_argument("--format", choices=["json", "text"], default="json")
    parser.add_argument('--artifact', choices=['auto', 'code', 'visual', 'content', 'analysis', 'mechanical'], help='artifact constraint; analysis does not imply complexity, mechanical still requires a mechanical task')
    parser.add_argument('--failed-attempts', type=int)
    parser.add_argument('--requires-live-tools', action='store_true')
    parser.add_argument("--touches-sensitive-surface", action="store_true", help="planned paths or behavior touch identity, signing, secrets, privacy or another sensitive surface")
    parser.add_argument("--stage", help="receiving stage identifier for an advisory handoff record")
    parser.add_argument("--skill-entry", type=Path, help="exact selected SKILL.md; requires --stage")
    args = parser.parse_args()
    try:
        policy = load_policy(args.project_policy)
        # Automatically preserve the nearest project privacy boundary, even when
        # an explicit machine profile is supplied. Capability is not data approval.
        for directory in (Path.cwd(), *Path.cwd().parents):
            candidate = directory / '.codex/model-routing.toml'
            if candidate.is_file():
                project = load_policy(candidate)
                levels = ['public', 'internal', 'confidential', 'restricted']
                privacy_values = [p.get('data_classification', 'internal') for p in (policy, project)]
                if any(value not in levels for value in privacy_values):
                    raise ValueError('unsupported project data_classification')
                if args.project_policy is None:
                    policy = project
                policy['data_classification'] = max(privacy_values, key=levels.index)
                break
        signals = policy.setdefault('task_signals', {})
        if not isinstance(signals, dict):
            raise ValueError('task_signals must be a table')
        if args.artifact is not None:
            signals['artifact'] = args.artifact
        if args.failed_attempts is not None:
            prior_failures = signals.get('failed_attempts', 0)
            if type(prior_failures) is not int or not 0 <= prior_failures <= 100:
                raise ValueError('policy failed_attempts must be an integer from 0 to 100')
            if not 0 <= args.failed_attempts <= 100:
                raise ValueError('CLI failed_attempts must be an integer from 0 to 100')
            signals['failed_attempts'] = max(args.failed_attempts, prior_failures)
        if args.touches_sensitive_surface:
            signals['touches_sensitive_surface'] = True
        if args.requires_live_tools:
            signals['requires_live_tools'] = True
        availability = policy.setdefault("availability", {})
        if not isinstance(availability, dict):
            raise ValueError("availability must be a table")
        for enabled, key, value in ((args.openai_unavailable, "openai", False), (args.astra_unavailable, "astra", False), (args.claude_available, "claude", True), (args.local_unavailable, "local", False)):
            if enabled:
                availability[key] = value
        decision = classify(args.task, args.privacy, args.risk, args.urgency, policy)
        if args.skill_entry and not args.stage:
            raise ValueError("skill-entry requires stage")
        if args.stage:
            decision["stage_handoff"] = stage_handoff(decision, args.stage, args.skill_entry)
    except ValueError as error:
        print(f"ERROR - {error}", file=sys.stderr)
        return 2
    if args.format == "json":
        print(json.dumps(decision, indent=2, sort_keys=True))
    else:
        for key in ("route", "model", "effort", "speed", "primary_skill", "completion_skill", "why", "data_boundary", "fallback", "re_evaluate_when"):
            value = decision.get("rationale") if key == "why" else decision.get(key)
            print(f"{key}: {value}")
        if "suggested_primary_skill" in decision:
            print("suggested_primary_skill: " + decision["suggested_primary_skill"])
        if "stage_handoff" in decision:
            print("stage_handoff: " + json.dumps(decision["stage_handoff"], sort_keys=True))
        print(f"fast_mode: {decision['fast_mode']}")
        print(f"openrouter: {decision['openrouter']}")
        print("review_gate: " + json.dumps(decision["review_gate"], sort_keys=True))
        if "stop_reason" in decision:
            print("stop_reason: " + decision["stop_reason"])
        if "external_data_gate" in decision:
            print(f"external_data_gate: {decision['external_data_gate']}")
        if "final_gate" in decision:
            print(f"final_gate: {decision['final_gate']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
