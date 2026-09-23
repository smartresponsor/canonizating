# Canon054DoctrinePhysicalIdentifierNamingRule — Doctrine Physical Identifiers Are Lower Snake Case

## Identity

Canon: `Canon054`
Gating mirror: `Canon054DoctrinePhysicalIdentifierNamingRule.php`

## Requirement

Doctrine-owned relational persistence uses PHP-native camelCase for properties and methods and `lower_snake_case` for physical database identifiers.

Standalone Doctrine ORM configuration MUST use `doctrine.orm.naming_strategy.underscore_number_aware` so implicit property, join-column, and related physical names materialize consistently with the Host application.

Explicit current Doctrine metadata names for tables, columns, join columns, indexes, and unique constraints MUST match `^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$`.

Application-owned index and constraint names MUST be deterministic lower_snake_case semantic identifiers. Column-level `unique: true` is non-canonical when it delegates the physical constraint name to Doctrine and produces hash-derived schema objects. Reusable system-field owners such as Objecting MUST express table-level invariants through owner-controlled Doctrine metadata policy so consumers do not duplicate those constraints. A standalone repository that consumes Objecting identity metadata MUST register `App\\Objecting\\ObjectBundle`; bundle-only consumers rely on the composing Host to activate Objecting once for the runtime. Custom kernels that implement `registerBundles()` manually MUST also register ObjectBundle when they execute Objecting identity metadata, because they can bypass `config/bundles.php`.

Examples:

- PHP `$deletedAt` -> database `deleted_at`
- PHP `$ownerId` -> database `owner_id`
- `attachment_link`, `project_vendor_sla`, and `uniq_attachment_uuid` are canonical physical identifiers

## Legacy ownership prefixes

Historical product abbreviations are not component ownership. In particular, the `sr_` physical table prefix is prohibited. Existing `sr_*` tables must be classified as dead legacy, data-bearing legacy requiring migration, or active capability state that must be re-homed under its actual component/domain owner.

Do not mechanically rename an `sr_*` table when its capability is obsolete or already materialized canonically. Empty unreferenced shadow tables should be removed by a guarded forward migration.

## Scope

This rule governs the **current Doctrine metadata contract**, not every historical migration statement.

Historical migrations may legitimately mention non-canonical identifiers in order to detect, rename, copy, or drop them. Canon030 remains responsible for proving that the complete migration chain converges to current Entity metadata.

Component/domain table-prefix requirements remain profile-owned by the existing database-prefix rule and are not duplicated here.

Singular/plural table vocabulary, reserved SQL words, foreign-key semantics, and identifier type strategy are intentionally outside this atomic rule.

## Prohibited

- camelCase, PascalCase, kebab-case, uppercase, or mixed-case physical identifiers in current Doctrine metadata;
- standalone ORM metadata using Doctrine's default naming strategy when it owns persisted Entity mappings;
- current Doctrine table names beginning with `sr_`;
- application-owned hash-derived `uniq_<hash>` / `idx_<hash>` schema-object names as the intended current contract;
- column-level `unique: true` where Doctrine owns the physical unique-constraint name;
- standalone Objecting identity consumers that do not activate `App\\Objecting\\ObjectBundle`;
- custom `registerBundles()` kernels that consume Objecting identity metadata but omit ObjectBundle;
- treating a historical product abbreviation as a component/domain namespace.

## Rationale

The Host application already uses Doctrine's underscore-number-aware naming strategy, and the materialized PostgreSQL and system SQLite schemas overwhelmingly follow lowercase snake case. Making that invariant explicit prevents standalone components from generating a different physical schema than the Host and prevents future migrations from restoring legacy naming drift.

## Guardability

Hard for current Doctrine metadata and standalone Doctrine configuration. Gating inspects Doctrine ORM applicability, repository Doctrine configuration, explicit application-authored ORM metadata names under `src/`, and implicit uniqueness declarations that delegate naming to Doctrine. Canon030 additionally proves that migrations converge to the resulting deterministic metadata contract. Historical migrations are deliberately excluded from direct naming failure.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "Doctrine ORM persistence owners; standalone Doctrine configuration and current ORM metadata under src/"
  extraction: [orm_dependency_presence, doctrine_config_presence, naming_strategy, metadata_identifier_kind, metadata_identifier_name]
  body_read: prohibited
  reasoning: none
  escalation: [ambiguous_doctrine_mapping_syntax, non_attribute_mapping_without_equivalent_extraction]
  executable_evidence: ["Gating Canon054 findings", "Canon030 schema-parity evidence"]
```
