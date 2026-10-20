# OpenUI integration notes

Version-Timestamp: 2026-10-18 17:40:06 AST

This is a dated source assessment, not a rolling compatibility promise. Recheck
the exact dependency graph, install scripts, advisories, license and network
behavior for each project's selected versions before executing third-party code.
No OpenUI runtime package was installed or exercised for this assessment.

## Choose the smallest integration

| Existing application | Starting point |
| --- | --- |
| React assistant with its own UI | `@openuidev/react-lang` with the project's own components |
| React assistant needing ready-made UI | Add `@openuidev/react-ui` only if its components fit |
| Existing chat state and transport | Keep them; use a matching adapter only where needed |
| Server prompt/schema generation | `@openuidev/lang-core`, matched to the renderer's language line |
| Vue, Svelte or Angular assistant | Its renderer's compatible language line, without assuming React feature parity |
| WordPress or static site | Keep native UI; assess a separately bounded assistant feature only when needed |
| Native mobile application | Verify a native renderer or approved web surface separately; React web support is insufficient evidence |
| Codex, Claude or another IDE | This skill guides integration; it does not replace the host's chat UI |

Published registry readback on 2026-10-18 found `lang-core` and `react-lang`
1.0.1, `react-ui` and `react-headless` 0.18.1, and Vue/Svelte/Angular renderers
0.4.2. React UI's peer contract includes `react ^18.3.1 || ^19.0.0` and
`zustand ^4.5.5`.
React UI 0.18.1 accepts `react-lang >=1.0.0 <2.0.0` and
`react-headless >=0.14.0 <0.19.0`; React Lang 1.0.1 depends on `lang-core ^1.0.1`.
The non-React renderers require compatible `lang-core` 0.4. At this snapshot,
the 1.0 additions require React: custom functions, custom actions and omitting
the `Action([...])` wrapper for a single action.
Pin a compatible set and lockfile after rechecking; do not apply one
version number to every package or execute a moving `@latest` scaffold.

Sources: [package catalog](https://github.com/thesysdev/openui#packages),
[React 1.0.1 registry](https://registry.npmjs.org/@openuidev%2freact-lang/1.0.1),
[React UI 0.18.1 registry](https://registry.npmjs.org/@openuidev%2freact-ui/0.18.1),
[1.0 compatibility](https://www.openui.com/docs/openui-lang/whats-new).

## Contract and responsibility boundaries

The identifiers below were read back from the linked official documentation on
2026-10-18. They are documentation evidence, not executed SDK acceptance. Recheck
them against the selected release before use.

1. The project owns `defineComponent` definitions, Zod prop schemas and descriptions,
   root component, allowed actions and registry version. Prop order is significant
   for positional arguments. Treat changes to those inputs as contract changes.
2. Build the library with `createLibrary`; generate instructions with
   `library.prompt()` from the same versioned definitions the client renders.
   Do not maintain a separate handwritten component API in the system prompt.
3. The application's server owns approved model access, prompt assembly, response
   streaming, quotas, cancellation and persistence. New provider use needs the
   existing project's approval; this framework supplies no inference entitlement.
4. The browser `Renderer` progressively renders the accumulated response.
   Inspect parser warnings/errors as well as successful visible fragments. A
   partially rendered interface can still be incomplete. Capture `onError` and
   appropriate parse diagnostics without logging private contents.
5. The browser's `toolProvider` exposes only named operations mapped to project
   endpoints. The server derives identity and tenant from the trusted session,
   checks object access and rejects unsupported operations and parameters.
   Generated IDs, action names and URLs never establish authority.
6. Action schema unions affect prompt/schema output but do not enforce action
   restrictions at runtime in the dated 1.0 documentation. Server authorization
   and explicit allowlists remain necessary even for well-typed actions.
7. Save responses only under the project's retention rules. Record language and
   registry versions when persistence is needed; redact sensitive form state,
   handle schema migration and invalidate incompatible saved interfaces.
8. Limit stream size, execution time, tool calls and concurrency. Restrict URL and
   media origins. Avoid arbitrary HTML/script execution; if required, design and
   review an isolated rendering boundary before enabling it.

Sources: [component definitions](https://www.openui.com/docs/openui-lang/defining-components),
[renderer](https://www.openui.com/docs/openui-lang/renderer),
[queries and mutations](https://www.openui.com/docs/openui-lang/queries-mutations),
[architecture](https://www.openui.com/docs/openui-lang/architecture),
[1.0 action limits](https://www.openui.com/docs/openui-lang/whats-new).

## Installation and outbound connections

Disable installation telemetry before dependency installation in both local and
CI environments, rather than after the first install. Use the project's existing
env mechanism; do not commit environment secrets or change machine-wide settings.
Runtime telemetry is documented as off by default. Installation telemetry,
runtime telemetry, remote inference and development script loading are separate
network surfaces.

`react-lang` auto-mounts a CDN DevTools widget in development. The reviewed
bootstrap requests major version `0`, outside an application lockfile's exact
dependency pin. Telemetry opt-out does not disable it. Verify a supported disable
or locally bundled arrangement against the selected release. If the no-CDN
requirement remains unresolved, hold private development data and use synthetic
fixtures in an isolated prototype. Do not invent an unverified disable switch.

Gateway, Autofix and hosted observability are optional external services with
their own data flows. Autofix may send generated responses, library definitions
and conversation context. Keep them out of the default integration. BYOK means
provider API credentials; a ChatGPT, Claude or Gemini subscription is not proof
of gateway or API access. Feedback commands also transmit externally. Deployment
helpers can transfer environment values. Neither is an implicit integration step.

Sources: [telemetry](https://www.openui.com/docs/openui-lang/telemetry),
[DevTools](https://www.openui.com/docs/api-reference/devtools),
[reviewed bootstrap](https://github.com/thesysdev/openui/blob/8d9c4c3b108a7b5352192a6a9d7327bdf7ea19b5/packages/react-lang/src/devtoolsBootstrap.ts),
[hosted reliability](https://www.openui.com/docs/reliability/installation),
[BYOK](https://www.openui.com/docs/gateway/byok),
[CLI](https://www.openui.com/docs/api-reference/cli).

## Reuse without copying vendor policy

Runtime source was reviewed at `8d9c4c3b108a7b5352192a6a9d7327bdf7ea19b5`.
Its [MIT license](https://github.com/thesysdev/openui/blob/8d9c4c3b108a7b5352192a6a9d7327bdf7ea19b5/LICENSE)
does not establish a license for the separate upstream coding skill repository.
The [upstream skill source](https://github.com/thesysdev/skills/tree/bcd93adc9185e333bc9a83b29f7d81d67ab1935f)
at `bcd93adc9185e333bc9a83b29f7d81d67ab1935f` had no LICENSE
and directed agents toward Gateway and deployment. Treat that material as
inspection-only reference. This package's text and template are original; no
vendor skill files, CLI, scripts, hooks or MCP server are included.
