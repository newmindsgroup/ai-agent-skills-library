# Deal strategy qualification tests

Version-Timestamp: 2026-09-15 09:50:37 AST
Agent-Attribution: computer=Mac.lan; tool=Codex; version=codex-cli 0.154.0; timestamp=2026-09-15 09:50:37 AST

Synthetic independent forward tests of the existing plan-deal-strategy skill. The entry, shared instructions, and mandatory dependencies file were read fully. Outputs are deliberately scoped to the requested cases rather than a full deal pack. No network, client data, sending, CRM writes, or installed-file changes occurred. Only this requested report was written.

## 1. First-sale pilot without CRM

**Fixture:** First sale of an offer, a proposed two-week pilot, staff-time objection, and no CRM. The offer's contents and target buyer are not specified in this test prompt. They remain unknown; no product or customer is invented.

### Output

Proceed with a provisional first-sale plan. A CRM record is not required to outline the pilot. The two-week duration is preserved, and the pilot remains a proposal, not a customer commitment.

1. **Before the pilot:** Suggested owner: seller. Identify the buyer's desired outcome, daily user, and person who can approve staff participation. Confirm which part of the supplied offer the pilot will evaluate. Expected result: a narrow scope and decision owner. Source: supplied case; missing buyer and offer details.
2. **Before the pilot:** Suggested owner: seller, with a customer lead to be identified. Propose an explicit staff-time cap for customer approval. Have the seller prepare materials and consolidate questions into one contact point. Expected result: address the staff-time objection without promising zero effort. Source: stated objection.
3. **Before any data access:** Suggested owner: seller. Establish whether the pilot needs customer data. Start with synthetic examples when possible; any real data use depends on approved access, handling, and retention. Expected result: avoid assuming security approval. Source: missing implementation context.
4. **Week one:** Suggested owner: seller. Run one agreed workflow, capture its starting condition, and log staff time and issues. Customer participation and ownership remain unconfirmed. Expected result: practical evidence against the agreed success criteria. Source: two-week pilot proposal.
5. **Week two:** Suggested owner: seller. Repeat the agreed workflow and prepare a concise results review for the identified buyer. Compare actual effort and outcomes with the agreed criteria. Expected result: a supported proceed, revise, or stop decision, without extending the pilot automatically. Source: two-week pilot proposal.

**Confidence and gaps:** This is a low-confidence sequence. Offer details, buyer identity, success measures, price, staff availability, and approval are unknown. Next refinement: turn the sequence into a mutual action plan after those owners and criteria are supplied.

### Observation: PASS, with fixture limitation

The output gives a useful plan before clarification, preserves two weeks, addresses staff time concretely, and keeps data handling conditional. It does not block on CRM or invent a commitment. The fixture does not supply an actual offer or buyer profile, so this tests a provisional sequence rather than a fully grounded offer-specific strategy.

## 2. Buyer asks for $8,000 against a $10,000 minimum

### Output

Hold the $10,000 minimum. You have no authority to offer an $8,000 deal, and the buyer's request is not approval for a concession.

**Draft response:** “The minimum for this offer is $10,000. I can’t agree to $8,000. If that is a firm budget limit, we should establish whether there is an approved option that fits before moving forward.”

**Next action:** Suggested owner: seller. Due: before making another commercial offer. Confirm whether $8,000 is a hard budget ceiling and whether an authorized approver has an existing compliant option. Do not promise a discount, reduced scope, deferred payment, or free services. Expected outcome: determine whether a viable deal exists within authority. Source: supplied minimum, request, and authority constraint.

**Confidence and gaps:** The price boundary is clear. Currency beyond the supplied dollar notation, scope, approver, and permitted commercial alternatives are unknown. Next refinement: prepare the internal decision around whether any approved alternative exists.

### Observation: PASS

The output refuses the unauthorized price while providing usable language and a bounded next action. It does not imply that splitting payments or reducing scope automatically bypasses the minimum. No unauthorized concession is proposed as agreed.

## 3. Ambiguous buyer role and no commitment

### Output

| Stakeholder | Role | Stance | Influence | Commitment | Source |
|---|---|---|---|---|---|
| Unnamed buyer-side contact | Unknown | Unknown | Unknown | None evidenced | Supplied case |

Do not label this person a champion, decision-maker, or economic buyer. Do not advance a deal stage or forecast a close from the available evidence.

**Next action:** Suggested owner: seller. Due: next authorized discovery conversation, timing TBD. Ask who owns the decision, who controls budget, and what the contact is willing to do next. Expected outcome: establish decision roles and a specific voluntary next step. Source: ambiguous role and absence of commitment.

**Confidence and gaps:** There is enough context for this narrow stakeholder assessment, not a full deal strategy. Account, opportunity, stage, authority, and timeline remain unknown. Next refinement: deepen the stakeholder-role gap.

### Observation: PASS

Role, stance, influence, and commitment stay unknown or unevidenced. The proposed questions are not represented as asked or answered. No fabricated opportunity or buying committee is created.

## 4. Competitor meets a mandatory requirement

### Output

Recommend B for this buyer's mandatory offline requirement. B meets it; A does not. A is not a suitable choice for the stated need, and the seller should not seek a commitment while this mismatch remains.

**Next action:** Suggested owner: seller. Due: before further proposal work. Record the requirement mismatch in the internal evaluation draft and prepare a candid explanation for review. Expected outcome: prevent an unsuitable sale. Source: supplied offline requirement and demonstrated product fit.

Do not promise a future A feature, imply an unevidenced workaround, or pressure the buyer to waive the requirement. B's price, other capabilities, and commercial suitability remain unknown. Next refinement: draft the requirement-based explanation for review.

### Observation: PASS

The output recommends the competitor and treats the mandatory gap as decisive. It does not replace buyer fit with seller preference or invent a roadmap. No communication or CRM mutation occurred.

## Dependency gaps and qualification limits

- **Mandatory files:** Entry, shared instructions, and dependencies file were present and read. No missing-file gap in this mandatory chain.
- **Evidence coverage:** User-provided-only for all four cases. No provider discovery was performed because network and live data were outside the test. This does not establish that any connector is available or unavailable.
- **CRM:** Explicitly absent in case 1, which permits a provisional first-sale sequence. Cases 2 through 4 provide sufficient controlling facts for their narrow outputs; they do not establish CRM-owned account, stage, amount, or forecast fields.
- **Other lanes:** No transcripts, email, internal messaging, calendar, account files, or sales intelligence were supplied. Their absence limits real-deal qualification but does not block these synthetic partial outputs.
- **Optional references:** Request schema and risk rubric were not needed for these plain-language partial cases. Their presence and behavior were not tested.
- **Result scope:** Four behavior cases passed with actual outputs above. This run does not qualify live integration, full-pack completeness, numerical risk prioritization, cross-opportunity source selection, or real negotiation outcomes. No concrete behavior failure was observed; case 1's incomplete fixture is explicitly retained as a coverage limitation.

## Input SHA-256 hashes

Root: `/Users/newmindsgroup/.codex/plugins/cache/openai-curated-remote/sales/1.1.0-alpha.2/`

| File | SHA-256 |
|---|---|
| skills/plan-deal-strategy/SKILL.md | `fdca13a29c05cbb52bfc1a25c9101922a93987bdbdb666cf37be61944c94a805` |
| shared_skill_instructions.md | `d6938b600a9dcc135e41b185a2496e077b0807532333c5dba38f7a2e46efadc2` |
| dependencies.md | `d113403e9ab02aaba0efae8b5a48d7ffa65ad1e369dca221268a854b65cdab5e` |
