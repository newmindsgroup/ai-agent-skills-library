# Skill Risk Audit - 2026-05-21

This audit is intentionally harsh. The goal is not to prove that a skill is malicious; it is to decide what should not live in a default, public, easy-to-install skill library where automatic routing could invoke it casually.

## Implementation Result

After implementing this audit, the safe default export contains 1,305 skills and the quarantine policy preserves 208 skills outside the default install path. One additional skill, `dogfood`, was quarantined during implementation because it directly depended on the quarantined `agent-browser` workflow and could perform real browser actions.

## Scope

- Audited valid source skills: 1,513 `SKILL.md` files under `sources/*/skills/*/SKILL.md`.
- Audited generated exports: 1,513 `SKILL.md` files under `dist/skills/*/SKILL.md`.
- Main upstream source: 1,457 of 1,513 skills come from `sickn33/antigravity-awesome-skills`.
- Existing risk metadata in `dist/skills-index.json` flags 637 skills for shell execution, 585 for secret sensitivity, 433 for security sensitivity, 63 for network access, and 33 for destructive system operations.
- Separate hygiene issue: `dist/skills` also contains 2,037 empty duplicate folders ending in ` 2`, ` 3`, or ` 4`. They are not valid skills because they contain no `SKILL.md`; they should be cleaned separately.

## Research Sources

- Local source of truth: `sources/*/skills/*/SKILL.md`
- Generated index: `dist/skills-index.json`
- Generated compatibility export: `dist/skills/*/SKILL.md`
- Public upstream reference: <https://github.com/sickn33/antigravity-awesome-skills>
- Upstream catalog reference: <https://github.com/sickn33/antigravity-awesome-skills/blob/main/CATALOG.md>
- OpenAI skills overview: <https://openai.com/academy/skills/>

## Audit Method

The audit was static only. I did not execute skill scripts, installers, exploit commands, browser automation, account automation, or network workflows.

I treated the following as deletion-level signals:

- Offensive security playbooks that teach exploitation, privilege escalation, scanning, credential abuse, red-team workflows, or use offensive tools.
- Skills that can act on real accounts, publish content, send messages, change calendars, issue refunds, deploy infrastructure, alter DNS, manage repos, or touch billing data.
- High-stakes legal, health, financial, payment, compliance, or regulated-domain advice that can create real-world harm if followed as instruction.
- Persona simulation of living or well-known public figures, especially when the skill presents itself as the person rather than a neutral analysis style.
- Meta-skills that can create, move, delete, or auto-route skills too broadly without a tight trust model.

## Recommendation Summary

- Delete from default library now: offensive/exploitation skills.
- Remove from default library and move to an optional gated connector pack: external-account automation skills.
- Quarantine or rewrite before public default install: high-stakes professional advice, health, finance, payment, compliance, and public-figure persona skills.
- Keep but gate: defensive security review skills that analyze code or configuration without teaching attack execution.
- Clean separately: empty duplicate `dist/skills/* 2`, `* 3`, and `* 4` folders.

## Delete From Default Now: Offensive Or Exploitation Skills

These are the strongest deletion candidates. They may be useful in a tightly controlled security lab, but they do not belong in the default library.

| Skill | Why it is flagged |
| --- | --- |
| `active-directory-attacks` | Explicitly teaches attacking Microsoft Active Directory, including credential harvesting, lateral movement, privilege escalation, and domain dominance. Delete. |
| `anti-reversing-techniques` | Helps resist reverse engineering and analysis; useful for malware-like evasive behavior. Delete from public default. |
| `api-fuzzing-bug-bounty` | Fuzzing and bug-bounty workflow can be legitimate, but it is still automated vulnerability discovery against APIs. Move to a gated security pack at minimum. |
| `aws-penetration-testing` | Cloud pentesting guidance can cross into unauthorized cloud attack paths. Delete from default. |
| `broken-authentication` | Focused on auth weakness exploitation patterns. Delete from default. |
| `burp-suite-testing` | Burp-driven web security testing belongs in a controlled security pack, not a general library. |
| `burpsuite-project-parser` | Parses Burp project data and audit findings; not directly malicious, but tightly coupled to offensive web testing workflows. Remove from default. |
| `cloud-penetration-testing` | Cloud offensive testing is too dangerous for automatic routing in a default install. |
| `ethical-hacking-methodology` | Broad hacking methodology. The "ethical" label is not enough for default trust. |
| `ffuf-claude-skill` | Fuzzing workflow with weak metadata. Delete. |
| `ffuf-web-fuzzing` | Web fuzzing can hit real targets and enumerate hidden paths. Delete from default. |
| `file-path-traversal` | Teaches path traversal testing/exploitation. Delete from default. |
| `html-injection-testing` | Injection testing belongs in a gated security pack. |
| `idor-testing` | IDOR testing can become unauthorized data access. Delete from default. |
| `linux-privilege-escalation` | Explicit privilege escalation. Delete. |
| `metasploit-framework` | Metasploit is an offensive exploitation framework. Authorized-use disclaimers do not make it safe for default install. |
| `network-101` | Penetration-testing lab workflow for network services. Remove from default. |
| `pentest-checklist` | General pentest execution checklist. Delete from default. |
| `pentest-commands` | Command-level pentest guidance is too operational. Delete. |
| `privilege-escalation-methods` | Explicit privilege escalation methods. Delete. |
| `protocol-reverse-engineering` | Reverse engineering can be legitimate, but protocol RE plus agent automation is sensitive. Quarantine at minimum. |
| `red-team-tactics` | Red-team tactics are offensive by design. Delete. |
| `red-team-tools` | Offensive tooling catalog. Delete. |
| `reverse-engineer` | Binary RE with IDA/Ghidra/radare2/x64dbg is sensitive. Remove from default; allow only in a lab pack. |
| `scanning-tools` | Covers vulnerability and network scanning tools. Too easy to misuse against real targets. |
| `shodan-reconnaissance` | Internet-exposed target reconnaissance. Delete from default. |
| `smtp-penetration-testing` | Service-specific pentesting. Delete from default. |
| `sql-injection-testing` | SQL injection testing can become exploitation. Delete from default. |
| `sqlmap-database-pentesting` | SQLMap is highly operational exploitation tooling. Delete. |
| `ssh-penetration-testing` | Service-specific pentesting. Delete from default. |
| `vulnerability-scanner` | Vulnerability scanning can be useful defensively, but should require explicit authorization and target scope. Remove from default. |
| `web-security-testing` | Broad web security testing should be gated, not automatic. |
| `windows-privilege-escalation` | Explicit privilege escalation. Delete. |
| `wordpress-penetration-testing` | CMS-specific pentesting. Delete from default. |
| `xss-html-injection` | XSS/injection testing guidance. Remove from default. |

## Remove From Default: Real-Account Automation And External Side Effects

These are not automatically malicious. The risk is that they can touch real systems: send emails, post to social media, change CRM data, deploy infrastructure, manage tickets, alter calendars, issue refunds, manipulate files, or modify repositories. They should become an optional, gated `connectors` or `external-actions` pack with explicit confirmation rules and per-tool permissions.

| Skill | Why it is flagged |
| --- | --- |
| `activecampaign-automation` | Marketing automation can email real contacts and alter campaigns. |
| `agent-browser` | Can log in, click, fill forms, scrape, automate desktop apps, and send Slack messages; it also says to prefer itself over built-in browser tools. Delete from default. |
| `agentmail` | Email/account workflow. External side effects. |
| `agentphone` | Phone/SMS or communications workflow. External side effects. |
| `airtable-automation` | Can read/write business databases. |
| `amplitude-automation` | Can touch product analytics data. |
| `asana-automation` | Can alter task/project state. |
| `bamboohr-automation` | HR data is sensitive. Remove from default. |
| `basecamp-automation` | Project/account side effects. |
| `billing-automation` | Billing workflows are high-impact. |
| `bitbucket-automation` | Repo/project changes. |
| `box-automation` | File storage access and data movement. |
| `brevo-automation` | Email marketing side effects. |
| `browser-automation` | General browser automation can perform real-world actions. |
| `cal-com-automation` | Calendar booking side effects. |
| `calendly-automation` | Calendar booking side effects. |
| `canva-automation` | Asset/design account changes. |
| `circleci-automation` | CI workflow manipulation. |
| `clickup-automation` | Task/project mutations. |
| `close-automation` | CRM and sales data changes. |
| `coda-automation` | Document/database mutations. |
| `confluence-automation` | Knowledge-base mutations. |
| `convertkit-automation` | Email marketing actions. |
| `datadog-automation` | Observability/account changes. |
| `discord-automation` | Can send or manage messages/communities. |
| `docusign-automation` | Legal/signature workflow. High stakes. |
| `dropbox-automation` | File access and data movement. |
| `figma-automation` | Design/account mutations. |
| `freshdesk-automation` | Support ticket mutations. |
| `freshservice-automation` | IT service-management mutations. |
| `github-automation` | Repo/issues/PR/actions mutations. |
| `gitlab-automation` | Repo/issues/CI mutations. |
| `gmail-automation` | Email access and sending via OAuth. |
| `google-analytics-automation` | Analytics/account access. |
| `google-calendar-automation` | Calendar mutations. |
| `google-docs-automation` | Document access and edits. |
| `google-drive-automation` | File storage access and sharing risk. |
| `google-sheets-automation` | Spreadsheet/database mutations. |
| `google-slides-automation` | Presentation edits/sharing. |
| `googlesheets-automation` | Duplicate Sheets connector; remove from default. |
| `helpdesk-automation` | Customer-support side effects. |
| `hubspot-automation` | CRM/marketing/sales mutations. |
| `instagram-automation` | Social publishing/account actions. |
| `intercom-automation` | Customer messaging and support data. |
| `jira-automation` | Project/ticket mutations. |
| `klaviyo-automation` | Marketing email/SMS side effects. |
| `linear-automation` | Issue/project mutations. |
| `linkedin-automation` | Social/account automation. |
| `linkedin-cli` | LinkedIn automation from CLI; remove from default. |
| `mailchimp-automation` | Email marketing side effects. |
| `make-automation` | Workflow automation can trigger broad external actions. |
| `microsoft-teams-automation` | Messaging and collaboration side effects. |
| `miro-automation` | Board/account mutations. |
| `mixpanel-automation` | Product analytics access. |
| `monday-automation` | Project/data mutations. |
| `notion-automation` | Workspace/document/database mutations. |
| `one-drive-automation` | File storage access and sharing risk. |
| `openclaw-github-repo-commander` | Repo command/control. Too much authority for default install. |
| `outlook-automation` | Email access and sending. |
| `outlook-calendar-automation` | Calendar mutations. |
| `pagerduty-automation` | Incident/on-call workflow side effects. |
| `payment-integration` | Payment workflow. High stakes. |
| `paypal-integration` | Payment workflow. High stakes. |
| `pipedrive-automation` | CRM mutations. |
| `posthog-automation` | Product analytics access and changes. |
| `postmark-automation` | Transactional email side effects. |
| `reddit-automation` | Social posting/account actions. |
| `render-automation` | Deployment/platform mutations. |
| `salesforce-automation` | CRM/account mutations. |
| `segment-automation` | Customer data pipeline changes. |
| `sendgrid-automation` | Email delivery side effects. |
| `sentry-automation` | Error-tracking account/project changes. |
| `shopify-automation` | Store/customer/product/order mutations. |
| `slack-automation` | Messaging/workspace side effects. |
| `square-automation` | Payment/business data side effects. |
| `stripe-automation` | Customers, charges, invoices, refunds, and subscriptions. Delete from default. |
| `stripe-integration` | Payment workflow. High stakes. |
| `supabase-automation` | Database/project automation, including possible SQL execution. Delete from default. |
| `telegram-automation` | Messaging/community side effects. |
| `tiktok-automation` | Social publishing/account actions. |
| `todoist-automation` | Task/project mutations. |
| `trello-automation` | Board/card mutations. |
| `twilio-communications` | SMS/voice/communications side effects and cost risk. |
| `twitter-automation` | Social posting/account actions. |
| `vercel-automation` | Deployments, domains, DNS, and environment variables. Delete from default. |
| `webflow-automation` | Website/CMS publishing side effects. |
| `whatsapp-automation` | Messaging side effects. |
| `whatsapp-cloud-api` | Messaging API integration. High side-effect risk. |
| `wrike-automation` | Project/task mutations. |
| `x-article-publisher-skill` | Publishes articles externally. Remove from default. |
| `x-twitter-scraper` | Platform scraping/automation risk. |
| `youtube-automation` | Channel/content/account actions. |
| `zapier-make-patterns` | Workflow automation can fan out to many external tools. |
| `zendesk-automation` | Customer support ticket mutations. |
| `zoho-crm-automation` | CRM mutations. |
| `zoom-automation` | Meeting/account actions. |

## Quarantine Or Rewrite: High-Stakes Advice

These should not be deleted because some could become valuable, but they are unsafe as generic instructions unless rewritten with strict boundaries, disclaimers, source requirements, and "do not provide professional advice" behavior.

| Skill | Why it is flagged |
| --- | --- |
| `advogado-criminal` | Criminal-law advice. Too high-stakes for a general skill. |
| `advogado-especialista` | Legal advice. Needs jurisdiction, disclaimers, and attorney-review boundaries. |
| `legal-advisor` | Generic legal-advisor framing is too broad. |
| `employment-contract-templates` | Legal/employment document generation risk. |
| `customs-trade-compliance` | Regulatory compliance risk. |
| `fda-food-safety-auditor` | FDA/food-safety compliance is regulated and high-impact. |
| `fda-medtech-compliance-auditor` | FDA/medical-device compliance is regulated and high-impact. |
| `it-manager-hospital` | Hospital IT decisions can affect sensitive systems and patient operations. |
| `claude-ally-health` | Health-oriented guidance. Needs medical boundaries. |
| `family-health-analyzer` | Health analysis. Needs medical boundaries. |
| `food-database-query` | Nutrition/health interpretation risk. |
| `goal-analyzer` | Health-goal analysis. Needs medical boundaries. |
| `health-trend-analyzer` | Health trend interpretation. Needs medical boundaries. |
| `mental-health-analyzer` | Mental-health interpretation is high stakes. |
| `occupational-health-analyzer` | Workplace health guidance is regulated/sensitive. |
| `oral-health-analyzer` | Dental/medical advice risk. |
| `sexual-health-analyzer` | Medical and sensitive personal data risk. |
| `skin-health-analyzer` | Medical advice risk. |
| `travel-health-analyzer` | Medical/travel health advice risk. |
| `weightloss-analyzer` | Medical/nutrition advice risk. |
| `wellally-tech` | Health-tech framing. Needs strict boundaries. |
| `crypto-bd-agent` | Crypto/finance risk. |
| `emblemai-crypto-wallet` | Wallet/crypto asset risk. |
| `pakistan-payments-stack` | Payments and regulatory risk. |
| `pci-compliance` | Compliance advice must be precise and auditable. |
| `quant-analyst` | Financial/trading advice risk. |
| `risk-manager` | Financial/enterprise risk advice can be high-impact. |
| `risk-metrics-calculation` | Quantitative finance/risk calculations need validation. |
| `startup-business-analyst-financial-projections` | Financial projections can be misused as advice. |
| `startup-financial-modeling` | Financial-modeling advice should be bounded. |
| `odoo-l10n-compliance` | Localization/compliance advice can be legally sensitive. |
| `security-compliance-compliance-check` | Compliance judgment needs evidence and scope controls. |
| `supply-chain-risk-auditor` | Useful but high-impact; should be gated with evidence standards. |

## Delete Or Rewrite: Public-Figure Persona Simulation

These are not "security dangerous" in the exploit sense, but they are questionable for a serious public library. They invite impersonation, brand/legal concerns, and low-trust outputs. If kept, rewrite as neutral "analysis frameworks" rather than "agent that simulates X."

| Skill | Why it is flagged |
| --- | --- |
| `007` | Fictional spy persona; also overlaps with covert/security framing. |
| `andrej-karpathy` | Public-figure simulation. Rewrite as "AI education / LLM pedagogy style analysis" or delete. |
| `bill-gates` | Public-figure simulation. Delete or rewrite. |
| `elon-musk` | Public-figure simulation. Delete or rewrite. |
| `geoffrey-hinton` | Public-figure simulation. Delete or rewrite. |
| `ilya-sutskever` | Public-figure simulation. Delete or rewrite. |
| `sam-altman` | Public-figure simulation. Delete or rewrite. |
| `steve-jobs` | Public-figure simulation. Delete or rewrite. |
| `warren-buffett` | Public-figure simulation plus finance-advice adjacency. Delete or rewrite. |
| `yann-lecun` | Public-figure simulation. Delete or rewrite. |
| `yann-lecun-debate` | Public-figure simulation. Delete or rewrite. |
| `yann-lecun-filosofia` | Public-figure simulation. Delete or rewrite. |
| `yann-lecun-tecnico` | Public-figure simulation. Delete or rewrite. |

## Quarantine: Meta-Skills With Too Much Authority

These are not bad ideas, but they should not be casually included in a default public library because they can affect routing, skill discovery, or skill filesystem state.

| Skill | Why it is flagged |
| --- | --- |
| `manage-skills` | Teaches create/edit/toggle/copy/move/delete operations across many agent tools and includes destructive file commands. Keep only for maintainers. |
| `agent-orchestrator` | Auto-scans, matches, and orchestrates skills. This overlaps with the repo's curated routing layer and can route too broadly. |
| `task-intelligence` | Says it activates all relevant agents before every task and escalates orchestration. Too broad for default behavior. |
| `skill-seekers` | Converts websites/repos/PDFs into skills. Useful, but it can import unreviewed content quickly. Gate it. |
| `cc-skill-continuous-learning` | Weak placeholder-like metadata and unclear behavior. Delete or rewrite. |
| `cc-skill-strategic-compact` | Weak placeholder-like metadata and unclear behavior. Delete or rewrite. |

## Keep But Gate: Defensive Security Skills

These raised security keywords but should not be deleted outright. They are useful if they stay scoped to defensive review, code auditing, hardening, and evidence-based reporting.

- `api-security-best-practices`
- `api-security-testing`
- `api-testing-observability-api-mock`
- `aws-compliance-checker`
- `aws-iam-best-practices`
- `aws-security-audit`
- `backend-security-coder`
- `cc-skill-security-review`
- `cloud/audit/security-auditor`
- `frontend-mobile-security-xss-scan`
- `frontend-security-coder`
- `gha-security-review`
- `malware-analyst`
- `memory-forensics`
- `security-audit`
- `security-auditor`
- `security-scanning-security-dependencies`
- `security-scanning-security-hardening`
- `security-scanning-security-sast`
- `skill-scanner`
- `threat-modeling-expert`
- `threat-mitigation-mapping`
- `top-web-vulnerabilities`
- `wireshark-analysis`
- `zeroize-audit`

## Cleanup Issue: Empty Duplicate Export Folders

These are not valid skills, but they are clutter and should be removed in a cleanup batch:

- Pattern: `dist/skills/* 2/`, `dist/skills/* 3/`, `dist/skills/* 4/`
- Count found: 2,037 empty folders
- Risk: confusion, noisy audits, bad repo hygiene
- Recommended action: delete empty duplicate directories only after confirming they remain empty.

## Bottom Line

My ruthless recommendation:

1. Remove the offensive/exploitation skills from the default library immediately.
2. Move all real-account automation skills into a separate opt-in connector pack with explicit confirmation and permission rules.
3. Quarantine high-stakes legal, health, finance, payments, and compliance skills until rewritten with strict safety boundaries.
4. Delete or rewrite public-figure persona simulation skills.
5. Keep defensive security skills only if they are explicitly defensive, scoped, and evidence-based.
6. Clean the empty duplicate export folders.

The current library is valuable, but it is too permissive for a default install. The dangerous part is not only malicious content; it is automatic routing plus high-authority instructions plus real external side effects.
