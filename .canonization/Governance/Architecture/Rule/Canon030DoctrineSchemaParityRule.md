# Canon030DoctrineSchemaParityRule — Doctrine Entities Are the Schema Source of Truth

## Identity

Canon: `Canon030`
Gating mirror: `Canon030DoctrineSchemaParityRule.php`

## Requirement
Current Doctrine Entity mapping/metadata is the source of truth for relational schema. The complete migration chain must reproduce a database schema that is fully equivalent to the current Doctrine metadata.

## Required Invariant
After all current migrations are applied to a clean database, Doctrine schema validation must report synchronization and a new schema diff must be empty.

## Prohibited
Do not treat migration SQL or an existing database schema as an independent competing model that may drift from current Entity metadata. Entity changes must be accompanied by migration changes until metadata, migrations, and resulting schema are symmetric.

## Clarification
An individual migration is normally a historical delta. The invariant applies to the complete migration chain: `all migrations from empty database == current Doctrine metadata schema`.

## Execution Contract
Persistence-owning repositories must expose an executable Composer/CI schema-parity command that performs Doctrine mapping/schema validation and migration-currentness/diff verification against an isolated or disposable database environment.

## Guardability

## Evidence Contract
```yaml
evidence_contract:
  coverage: "Doctrine applicability metadata and executable schema-parity contract"
  extraction: [orm_dependency_presence, migrations_dependency_presence, parity_script_capabilities]
  body_read: targeted_on_failure
  reasoning: none_until_executable_failure
  escalation: [executable_parity_failure, custom_doctrine_factory, custom_metadata_mapping, parity_command_unavailable]
  executable_evidence: ["Doctrine schema validation and migration parity command output", "Gating Canon030 findings"]
```
