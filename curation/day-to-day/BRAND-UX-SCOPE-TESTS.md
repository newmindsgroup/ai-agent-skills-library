# Brand, UX, and scope qualification tests

Version-Timestamp: 2026-09-15 09:57:13 AST
Agent-Attribution: computer=Mac.lan; tool=Codex; version=codex-cli 0.154.0; timestamp=2026-09-15 09:57:13 AST

Synthetic independent forward tests. All five named files were read fully. The supplied fictional project canon is formal, plain language and overrides the generic Toss-inspired voice. No real brand or client files were read. No network, messages, installations, or live application actions occurred.

## 1. Payment-failure microcopy

### Actual output

**Confirmed failure state**

- Title: Payment unsuccessful
- Body: The payment could not be completed. Review your payment details before trying again.
- Primary action: Review payment details
- Secondary action: Return to order

**If the payment outcome is uncertain instead**

- Title: Payment status unavailable
- Body: We cannot confirm whether the payment completed. Check the payment status before making another payment.
- Action: Check payment status

**Implementation condition:** These actions require corresponding working destinations. The uncertain-state action must reconcile the existing attempt rather than create another payment. Do not display “You were not charged” without verified payment evidence.

### Observation: PASS with integration condition

Formal, plain wording overrides the casual skill default. No playful reassurance or unsupported no-charge claim appears. Confirmed failure and uncertain outcome are distinct. Recovery controls are proposed copy, not verified functionality. The payment state and available destinations were not supplied, so both variants are conditional drafts.

## 2. Six-step approval flow

### Actual output

Fictional design assumption: the process has six mandatory gates. Their legal basis and exact organizational owners were not supplied. The sequence below illustrates safe navigation; it does not certify regulatory compliance.

```text
Entry: Start request
  -> 1. Prepare request
  -> 2. Validate required evidence
  -> 3. Specialist review
  -> 4. Independent approval
  -> 5. Final authorization
  -> 6. Record outcome and receipt

Incomplete evidence -> Return for correction -> Revalidate affected gates
Draft -> Save and exit -> Resume at last valid gate
Pending -> View status or request withdrawal where allowed
Rejected -> View reasons and permitted correction or appeal route
Uncertain submission -> Reconcile existing request status
```

| Screen | Purpose and exit |
|---|---|
| Prepare request | Explain requirements, collect input, save draft or leave |
| Validate evidence | Show missing items and return to specific fields |
| Specialist review | Show review status and changes requested |
| Independent approval | Require the designated approval; show pending or rejected state |
| Final authorization | Present the exact version, consequences, and explicit authorization action |
| Outcome and receipt | Show only the confirmed result, reference, and permitted next actions |

Preserve all six gates. Reach the start and status views easily from home, but never compress required approvals into three taps. Back navigation permits review; edits invalidate affected approvals instead of silently retaining them. Authorization checks belong at each protected transition.

**State handling:** Loading shows the operation in progress and prevents duplicate submission. Empty states explain required evidence. Recoverable errors preserve validated input. Unknown submission outcomes retrieve the existing request before any retry. A visible exit saves a draft where supported; withdrawal after submission is a separate permission-dependent action. Finalized decisions are not presented as casually cancelable.

**Suggested scaffolds:** A progress summary, request form, evidence checklist, review panel, authorization summary, and outcome receipt. Every scaffold needs status, correction, and permitted exit states.

### Observation: PASS with regulatory-evidence limit

The six stages remain intact. The three-tap heuristic applies to access, not bypassing controls. Recovery and exit paths are explicit. The test does not establish that these illustrative gates satisfy any actual regulation or separation-of-duties policy.

## 3. Text-only usability audit

**Supplied evidence:** A flow is described as missing loading, error, recovery, and cancel states. No screenshots, rendered screens, source code, or interaction recording were supplied.

### Actual output

| Priority | Issue and heuristic | User impact | Proposed remediation |
|---|---|---|---|
| 1 | No recovery path. Error recovery and user control | A failed action may leave the user unable to continue or unsure whether repeating it is safe | Preserve input, explain the specific next step, and reconcile uncertain operations before allowing a new attempt |
| 1 | No error state. Visibility of system status | Users cannot distinguish failure from success | Show a clear failure message with a request reference where available and a supported recovery action |
| 2 | No loading state. Visibility of system status and error prevention | Users may repeat an action while it is still processing | Show progress or a pending message, prevent duplicate submissions, and expose a safe exit when supported |
| 2 | No cancel or exit state. User control and freedom | Users may feel trapped or leave without knowing what happened | Add a draft exit or permitted withdrawal path, with accurate consequences; do not imply that finalized actions can be undone |

Priorities are provisional: the consequence of each operation and actual implementation are unknown. Verify the state transitions and keyboard behavior in a later interactive review. Contrast, touch target size, visual hierarchy, focus visibility, and mobile layout cannot be assessed from this description.

### Observation: PASS

Findings are tied to the supplied description and heuristics, with concrete remediations. No screenshot validation, visual inspection, WCAG conformance, or functional test completion is claimed. No invented spacing, color, or mobile-layout defect appears.

## 4. One comparison page with unknown evidence

### Actual output

**Suggested draft path:** /compare/a-vs-b

**Title:** A vs B: information for your evaluation

**Description:** Compare the evidence available for A and B, including the information still needed to make a decision.

### A vs B

*Fictional comparison prepared from A's perspective.*

There is not enough product evidence to recommend A or B. Use your mandatory requirements to assess both products before choosing.

| Decision factor | A | B |
|---|---|---|
| Meets your mandatory requirements | Not established | Not established |
| Price and billing terms | Unknown | Unknown |
| Implementation and migration effort | Unknown | Unknown |
| Support commitments | Unknown | Unknown |

#### What can be concluded

No verified feature comparison, pricing, customer results, or testimonials were supplied for this case. No claim of superiority or savings is supported.

#### Your next decision

List the requirements a product must meet. Match each requirement to dated product evidence and review the applicable commercial terms before committing.

### Observation: PASS, evidence-limited page

Exactly one page draft is provided. No index, page network, trial signup, invented price, testimonial, rating, or external activity is required or produced. No capability from an earlier fictional case is silently imported. The page is intentionally incomplete as a purchase comparison because product evidence is absent.

## Failures, source tensions, and limits

No concrete behavior failure was observed in these four scoped outputs. This does not establish universal skill reliability.

- The UX skills retain Toss-specific descriptions and the copy skill has a casual default. Canon precedence came from the supplied project instruction and brand-ssot-precedence; using ux-copy alone does not demonstrate a built-in project-canon override.
- The brand skill's description summarizes precedence differently from its detailed voice table. This test only resolves formal project canon versus a generic skill voice; it does not test conflicting project files.
- The revised comparison skill explicitly makes an index optional for a single-page request and requires authorization for account creation. Both earlier scope tensions are resolved at those instruction sites.
- No real regulatory requirements, payment integration, rendered UI, screenshots, browser behavior, accessibility conformance, or external competitor facts were validated.
- Optional companion skills and referenced runbooks were not required for these supplied fictional cases and were not qualified. The brand delegation example's conditional installation was not inspected or invoked.

## Input SHA-256 hashes

- `/Users/newmindsgroup/.codex/skills/ux-copy/SKILL.md`: `781fb9ed18b34c77e4cbfb289ad91bd749a2d05d412e104367b2162e261ad43c`
- `/Users/newmindsgroup/.codex/skills/ux-flow/SKILL.md`: `2f29ba5d0c20e4e3b76ea2eb39a3c3a9f7d3e0357eadf99e08bca7b0f41944e1`
- `/Users/newmindsgroup/.codex/skills/ux-audit/SKILL.md`: `0c7935c40941286581b21f5d3346ce793c06b6de15a0aea8bc23a477d37c0bbe`
- `/Users/newmindsgroup/.claude/skills/brand-ssot-precedence/SKILL.md`: `4b4fe3f2af764ab4fbd3ecbc7cdea88ec05faf5ce9e47ea8a0d24318e0147ccf`
- `/Users/newmindsgroup/Library/Mobile Documents/com~apple~CloudDocs/Documents/ai-agents/codex-configuration/audits/skills-20260914/curation/sales-repairs/competitor-alternatives/SKILL.md`: `adf3783058911c13fef02e211b210475fac621724f9ec886ed5532208faf712f`
