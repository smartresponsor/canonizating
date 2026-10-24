# Canon068LocalRuntimeEndpointTopologyRule — Local Runtime Endpoints Are Stable and Non-Overlapping

## Identity

Canon: `Canon068`
Gating mirror: `Canon068LocalRuntimeEndpointTopologyRule.php`

## Requirement

The platform MUST use one canonical local endpoint topology. Numeric endpoint authority is identical on Windows and Ubuntu; only orchestration differs.

| Runtime | Canonical endpoint | Ownership |
| --- | --- | --- |
| Symfony composition Host (`App`) | `http://127.0.0.1:8000` | persistent Host HTTP runtime |
| Mobiling Mobile Edge listener | `http://127.0.0.1:8080` | host-side Mobile Edge HTTP runtime |
| Android emulator -> Mobile Edge | `http://10.0.2.2:8080` | emulator host bridge, not a listener |
| iOS/local -> Mobile Edge | `http://localhost:8080` | local client access alias |
| Console MCP ChatGPT OAuth | `http://127.0.0.1:3333/mcp` | OAuth transport and only legal public Cloudflare upstream |
| Console MCP Codex bearer | `http://127.0.0.1:3334/mcp` | loopback-only Codex transport |
| Console MCP managed browser CDP | `127.0.0.1:9223` | primary supervised browser control endpoint |
| Console MCP standby CDP | `127.0.0.1:9222` | reserved standby/compatibility; may be unbound |

These ownership domains MUST NOT be substituted merely because another port is free.

The App Host MUST NOT use `8080` as a fallback development port. Mobile Edge MUST NOT use `8000` as a fallback listener. Application runtimes MUST NOT bind `3333`, `3334`, `9222`, or `9223`.

Cloudflare/public exposure MUST target only `127.0.0.1:3333`. Port `3334` MUST remain loopback-only and MUST NOT be used for ChatGPT connector, OAuth, or public smoke traffic.

Android `10.0.2.2` is an emulator routing alias and MUST NOT be treated as a host listener. `localhost:8080` is a valid local/iOS client alias but does not replace the host listener `127.0.0.1:8080`.

`9223` is primary managed CDP on Windows and Ubuntu. `9222` is reserved standby/compatibility and may be unbound. Foreign/application ownership of either CDP port is drift.

## Operating-system realization

Windows and Ubuntu MUST preserve the same port numbers and ownership.

- Windows realizes authority through watchdog/Scheduled Task/interactive supervision.
- Ubuntu realizes authority through systemd-managed Console MCP, browser, and cloudflared services.

OS-specific launch machinery MUST NOT redefine endpoint authority.

## Enforcement ownership

Gating owns deterministic repository/configuration parity.

Console MCP / CanonScanning owns live runtime evidence during autonomous RC and nightly orchestration. When a runtime is expected active, the observed listener/process/control endpoint MUST match this authority. A correctly configured repository with a process launched on a substitute port is runtime drift.

Runtime absence is not automatically a failure when that runtime is not required for the current execution. A conflicting listener on a reserved canonical endpoint or an expected runtime on a non-canonical substitute endpoint MUST be reported explicitly.

## Guardability

Hard for deterministic repository/configuration surfaces. Runtime + hard when Console MCP/CanonScanning has listener/process evidence. Contextual only for whether a runtime is required to be active.

## Evidence Contract

```yaml
evidence_contract:
  coverage: "App Host, Mobiling Mobile Edge/client aliases, Console MCP transports/Cloudflare/browser CDP on Windows and Ubuntu"
  extraction: [repository_identity, runtime_role, configured_host, configured_port, client_access_alias, tunnel_upstream, observed_listener, observed_process_owner, observed_control_port]
  body_read: bounded_configuration_only
  reasoning: none
  escalation: [runtime_applicability_ambiguous, unsupported_launch_surface, conflicting_runtime_owner, observed_process_identity_ambiguous]
  executable_evidence: ["Gating Canon068 repository endpoint-topology findings", "Console MCP/CanonScanning live endpoint-topology evidence when runtime execution applies"]
```
