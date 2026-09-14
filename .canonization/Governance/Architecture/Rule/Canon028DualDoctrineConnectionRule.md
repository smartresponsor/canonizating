# Canon028DualDoctrineConnectionRule — Persistent Standalone Applications Separate Data and Infra Connections

## Identity

Canon: `Canon028`
Gating mirror: `Canon028DualDoctrineConnectionRule.php`

## Requirement
A standalone Symfony application that owns relational persistence declares distinct Doctrine DBAL connections for primary data and infrastructure/system storage. Canonical connection role names are `data` and `infra`, with PostgreSQL and SQLite respectively. The `infra` connection is file-backed SQLite unless a later canon explicitly defines another storage form.

## Prohibited
Do not collapse both storage roles into one universal production connection when the application participates in both platform data and infrastructure persistence.

## Rationale
Explicit connection roles make engine ownership visible in configuration and prevent accidental persistence of system/infrastructure state into the primary data database or vice versa.

## Exceptions
Pure libraries and components with no relational persistence are outside this rule. A component using only one storage role may omit the unused connection when that limitation is explicit and the component is not a full standalone persistent application.

## Guardability
Hard for applications declaring both roles; semantic/profile-aware for deciding whether a persistence-owning component legitimately needs only one role.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "Doctrine applicability and connection-role configuration metadata"
  extraction: [persistence_applicability, connection_names, drivers, database_urls_or_paths]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [single_role_persistence_claim, connection_role_ownership_ambiguous]
  executable_evidence: ["Gating Canon028 findings"]
```
