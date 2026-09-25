# Canon027DatabaseEngineBaselineRule — Canonical Relational Stack Is PostgreSQL Plus SQLite

## Identity

Canon: `Canon027`
Gating mirror: `Canon027DatabaseEngineBaselineRule.php`

## Requirement
The canonical platform relational database stack uses PostgreSQL and SQLite. PostgreSQL is the primary/data relational engine; SQLite is the infrastructure/system relational engine and is file-backed by default.

## Scope
This rule declares the supported engine stack and high-level connection roles. It does not yet canonize which individual entity families, menus, comments, messages, or other records belong to which engine.

## Prohibited
Do not substitute MySQL, MariaDB, or another relational engine as the canonical production data/system pair without an explicit canon change.

## Rationale
Agents and components must know which database technologies form the supported platform stack even when detailed data ownership remains component-specific.

## Guardability
Hard where Doctrine/container configuration declares production relational drivers: canonical drivers are `pdo_pgsql` and `pdo_sqlite`.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "Doctrine dependency and DBAL configuration metadata"
  extraction: [doctrine_dependencies, declared_dbal_drivers, connection_names]
  body_read: prohibited
  reasoning: none
  escalation: [custom_driver_wrapper_or_unresolved_env_driver]
  executable_evidence: ["Gating Canon027 findings"]
```
