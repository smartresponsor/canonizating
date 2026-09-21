# Canon051RepositoryHasNoOrchestrationDependencyRule — Repository Has No Orchestration Dependency

## Identity

Canon: `Canon051`
Gating mirror: `Canon051RepositoryHasNoOrchestrationDependencyRule.php`

## Requirement

Repository classes own persistence access and must not orchestrate controllers, handlers, services or side-effect infrastructure.

## Prohibited

Repositories must not depend on Controller, Handler, Service, Messenger bus, HTTP client, Mailer, Notifier, RequestStack or Session orchestration types.

## Rationale

Persistence access remains deterministic and reusable when business/application orchestration stays outside repositories.

## Exceptions

Doctrine persistence infrastructure required to implement repository access is allowed.

## Guardability

Hard for listed runtime types and project role imports.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "src/Repository PHP source"
  extraction: [relative_path, imported_type, runtime_type]
  body_read: candidates_only
  reasoning: none
  escalation: []
  executable_evidence: ["Gating Canon051 findings"]
```
