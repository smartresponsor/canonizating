# Canon044ObjectingSystemFieldNamingRule — Objecting System Fields Are Entity-Native

## Identity
Canon: `Canon044`
Gating mirror: `Canon044ObjectingSystemFieldNamingRule.php`

## Requirement
Objecting owns reusable system-field semantics, field packs, Doctrine embeddables, traits, interfaces, and ownership vocabulary. Persisted system fields themselves use entity-native names and MUST NOT carry an `object` or `objecting` prefix. This applies to `objecting/object` and every consumer of that package.

Canonical examples are `uuid`, `slug`, `created_at`, `created_by`, `modified_at`, `modified_by`, `deleted`, `deleted_at`, `deleted_by`, `version`, `active`, `status`, `first_title`, and `published_at`. The same invariant applies to Doctrine physical column names and Doctrine-mapped PHP properties: `created_at` / `$createdAt` are canonical; `object_created_at`, `objecting_created_at`, `$objectCreatedAt`, and `$objectingCreatedAt` are not.

## Ownership vocabulary versus field vocabulary
`Object` / `Objecting` remains valid for ownership/type names such as `object_audit`, `object_identity`, `ObjectAuditEmbeddable`, `ObjectAuditEmbeddableTrait`, and `ObjectAuditedInterface`. Logical field-pack identifiers remain `object_*`; persisted fields do not.

## Prohibited
Do not introduce or restore prefixed Objecting system fields. Historical migrations, old archives, schema mirrors, generated artifacts, or previous implementations do not authorize restoration of prefixed active fields. Consumer repositories must consume the current Objecting packs instead of cloning prefixed system fields locally.

## Migration rule
When a prefixed system field exists, migrate it atomically to the entity-native name and update active Doctrine mapping, migrations/schema transition artifacts, serializers, DTOs, forms, fixtures, tests, schema mirrors, indexes, and local documentation.

## Guardability
Hard for Doctrine mapping. Gating identifies `objecting/object` itself and Composer consumers and rejects explicit Doctrine column names beginning `object_` or `objecting_` plus Doctrine-mapped PHP properties beginning `object` or `objecting`. Logical pack/type ownership names are outside that scan.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "objecting/object and Composer consumers; Doctrine-mapped PHP fields and explicit Doctrine physical column names under src/"
  extraction: [composer_package_name, objecting_dependency, relative_path, mapped_property_name, doctrine_column_name]
  body_read: prohibited
  reasoning: none
  escalation: [ambiguous_doctrine_mapping_syntax]
  executable_evidence: ["Gating Canon044 findings"]
```
