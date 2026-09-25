# Canon046VendorIdentityRule — Vendor Identity Is the Cross-Component User Identity

## Identity

Canon: `Canon046`
Gating mirror: `Canon046VendorIdentityRule.php`

## Requirement

The platform uses `VendorEntity.id` as the canonical cross-component identifier for user/vendor identity. Active runtime contracts express the scalar identifier as `vendorId` in PHP/API/DTO vocabulary and `vendor_id` in persisted Doctrine/SQL vocabulary.

`VendorEntity.id` is the PostgreSQL primary key of the Vendor root and is the platform-wide identity key used to relate vendor/user-owned data across components. Components must reference that identity instead of introducing a parallel tenant identity.

## Prohibited

Active runtime code and configuration must not introduce or retain `tenantId`, `tenant_id`, `TenantId`, `TenantIdentity`, or equivalent tenant-identity vocabulary as the identifier for platform vendor/user ownership.

Do not create a separate Tenant entity, Tenant primary key, tenant-scoped identity layer, or translation layer whose only purpose is to rename Vendor identity.

## Canonical naming

- PHP properties, arguments, DTO/value fields, query objects and API-facing camelCase keys: `vendorId`.
- Doctrine columns, SQL fields and snake_case serialized persistence keys: `vendor_id`.
- Object relation/property when an Entity relation is carried directly: `vendor`.
- Root identity source: `VendorEntity.id`.

The written business term remains “Vendor ID”; the PHP identifier spelling is `vendorId`, not `vendorID`.

## Migration rule

When active code currently uses tenant identity vocabulary for the same platform identity, migrate the complete active contract atomically: Entity/Doctrine mapping, DTO/value objects, request/query parameters, security/permission checks, search/index payloads, serializers, repositories, fixtures, tests, and current documentation.

Historical migrations, changelogs, compatibility notes, and explicitly versioned transition records may mention `tenantId` or `tenant_id` only when they describe the old side of a migration. Historical vocabulary must not remain an active runtime contract or be reintroduced into new code.

## Rationale

One cross-component identity removes redundant tenant abstractions, prevents identity translation drift, and keeps ownership joins consistent across the platform. Vendor identity already represents the platform's user/multitenancy boundary; a parallel Tenant identity would create a second source of identity truth.

## Exceptions

A business concept genuinely named “tenant” that is not user/vendor/platform identity may exist only when its semantics are independently evidenced and it does not reuse the canonical vendor-ownership role. Such a concept must not use `tenantId` merely as an alias for `VendorEntity.id`.

Third-party payloads may contain external tenant-named fields at the integration boundary. They must be translated into the canonical internal Vendor identity contract before becoming stable internal application state.

## Guardability

Hard for active first-party PHP/config identity vocabulary. Semantic for distinguishing a genuinely independent business tenant concept or an external transport field from platform Vendor identity.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "active first-party PHP source plus component-owned configuration carrying identity vocabulary"
  extraction: [relative_path, tenant_identity_tokens, vendor_identity_tokens, declaration_or_config_context]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [tenant_token_in_business_specific_context, third_party_transport_boundary, compatibility_transition]
  executable_evidence: ["Gating Canon046 active identity-vocabulary findings"]
```
