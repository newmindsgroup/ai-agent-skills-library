---
name: twilio-communications
description: 'Use when building Twilio SMS, voice, WhatsApp, webhook, retry, rate-limit, or Verify/OTP communication features with production safeguards.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/twilio-communications/SKILL.md'
  imported_at: '2026-05-09'
---

# Twilio Communications

Build communication features with Twilio across SMS, voice, WhatsApp Business, webhooks, and Verify. Keep compliance, credential safety, opt-out handling, rate limits, and delivery failure paths visible from the beginning.

## When to Use

- Sending transactional SMS, alerts, reminders, OTPs, or WhatsApp messages through Twilio.

- Building IVR, voice call, TwiML, or webhook handling flows.

- Implementing Twilio Verify, delivery status callbacks, retry queues, or communication fallback channels.

- Auditing Twilio code for exposed credentials, signature validation, opt-out handling, rate limits, or phone-number validation.

## When Not to Use

- The product only needs in-app notifications or email and no phone/WhatsApp channel is required.

- The request asks for bulk messaging without consent, opt-out handling, or jurisdiction-specific compliance review.

- The code would expose Twilio credentials to browsers, mobile clients, logs, or public repositories.

## Core Workflow

1. Choose the channel and compliance path first: SMS, WhatsApp, voice, Verify, A2P 10DLC, consent, opt-out, and template rules.

2. Keep credentials server-side in environment or secret storage and prefer API keys over broad auth-token usage where possible.

3. Validate E.164 phone numbers, message length, channel constraints, and recipient consent before sending.

4. Implement Twilio exception handling with specific known error codes, retry rules, and user-facing fallback states.

5. Validate webhook signatures, respond quickly, and move slow work into queues or background processors.

6. Monitor delivery, opt-outs, rate limits, Verify attempts, and anomalous error spikes.

## Reference Map

Read `references/full-guidance.md` when the task needs the complete examples and edge cases. It includes:

- SMS sending, Verify/OTP, TwiML IVR, WhatsApp Business, webhook handler, and retry/rate-limit implementation patterns.

- Sharp edges for opt-outs, unreachable phones, carrier filtering, webhook signature validation, WhatsApp session windows, exposed tokens, and Verify rate limits.

- Validation checks for hardcoded credentials, client-side secrets, missing E.164 validation, absent exception handling, and missing opt-out checks.

## Safety and Quality Rules

- Never hardcode Account SID, Auth Token, API keys, phone numbers, or webhook signing secrets.

- Always honor STOP/START and maintain application-level opt-out state before sending.

- Validate every inbound webhook signature before trusting payload contents.

## Progressive Loading

Start with this entrypoint for routing and planning. Load `references/full-guidance.md` only after the task clearly requires deep implementation detail, code examples, validation checklists, or troubleshooting guidance.
