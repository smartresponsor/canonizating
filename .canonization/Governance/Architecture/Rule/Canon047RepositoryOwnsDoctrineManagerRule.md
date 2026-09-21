# Canon047RepositoryOwnsDoctrineManagerRule — Repository Owns Doctrine Manager Access

## Identity

Canon: `Canon047`
Gating mirror: `Canon047RepositoryOwnsDoctrineManagerRule.php`

## Requirement

Direct dependencies on Doctrine `EntityManagerInterface` or `ManagerRegistry` belong under `src/Repository/`. Other application roles consume repository contracts rather than managing persistence infrastructure directly.

## Prohibited

Controllers, handlers, services, entities and other non-repository runtime classes must not inject or resolve Doctrine manager infrastructure directly.

## Rationale

Repository ownership keeps persistence orchestration explicit and prevents EntityManager access from leaking across application responsibilities.

## Exceptions

Symfony/Doctrine bootstrap configuration is configuration, not application source, and is outside this source rule.

## Guardability

Hard for first-party PHP source.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "first-party PHP source"
  extraction: [relative_path, doctrine_manager_type]
  body_read: candidates_only
  reasoning: none
  escalation: []
  executable_evidence: ["Gating Canon047 findings"]
```
