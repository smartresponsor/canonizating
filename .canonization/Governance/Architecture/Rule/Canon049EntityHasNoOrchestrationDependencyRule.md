# Canon049EntityHasNoOrchestrationDependencyRule — Entity Has No Orchestration Dependency

## Identity

Canon: `Canon049`
Gating mirror: `Canon049EntityHasNoOrchestrationDependencyRule.php`

## Requirement

Entity classes model persistence state and invariants. They must not depend on application orchestration roles or runtime side-effect services.

## Prohibited

Entity code must not depend on Controller, Handler, Service, Repository, Messenger bus, service container, HTTP client, Mailer, Notifier or RequestStack orchestration types.

## Rationale

Entities remain persistence-focused and reusable when orchestration stays outside them.

## Exceptions

Framework persistence mapping attributes and Doctrine collection/value infrastructure are not orchestration dependencies.

## Guardability

Hard for listed dependency types and project role imports.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "src/Entity PHP source"
  extraction: [relative_path, imported_type, runtime_type]
  body_read: candidates_only
  reasoning: none
  escalation: []
  executable_evidence: ["Gating Canon049 findings"]
```
