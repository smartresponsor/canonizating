# Canon067RepositoryRootEntityRule — Canonical Components Own a Root Entity

## Identity

Canon: `Canon067`
Gating mirror: `Canon067RepositoryRootEntityRule.php`

## Requirement

Every canonical Symfony component repository that participates in application composition MUST own its repository root Entity.

The root Entity identity is derived from the Composer package subject token. For a package named:

`<component-token>/<subject-token>`

the canonical repository root Entity is:

`src/Entity/<SubjectToken>/<SubjectToken>Entity.php`

where `<SubjectToken>` is the StudlyCase form of the Composer package subject token. The file MUST declare `<SubjectToken>Entity` as a PHP class.

Examples:

- `ordering/order` owns `src/Entity/Order/OrderEntity.php`;
- `taxating/taxation` owns `src/Entity/Taxation/TaxationEntity.php`.

The root Entity is owned by the component repository itself. A Host application that installs or composes the component MUST NOT satisfy this requirement by declaring a Host-owned substitute Entity for that component.

Additional Entity families remain free to use the canonical `src/Entity/<DomainToken>/...` topology. Their existence does not replace the repository root Entity.

## Explicit exceptions

The following capability packages are exempt from the Entity and root-Entity requirement:

- `interfacing/interface`;
- `viewing/view`;
- `gating/gate`.

For these packages, `src/Entity/`, Doctrine entities, and a repository root Entity are all optional both in standalone execution and when the package is composed into a Host application.

This is an absence-of-obligation exception, not a prohibition. An exempt package MAY own an Entity if a real persistence responsibility later requires one, but no Entity may be introduced merely to satisfy this canon.

## Root responsibility

The repository root Entity is the canonical persistence identity and relationship-composition anchor for the component subject. It may own primary identity, Doctrine relations, and minimal persistence metadata needed to compose the component.

Domain-specific payload remains in appropriate additional Entity types rather than accumulating in the root solely because it is the root.

## Rationale

A composable persistence-owning component without its own root Entity has no repository-local identity/composition anchor and pushes ownership ambiguity into the Host. Requiring the root Entity keeps persistence identity with the component that owns the subject while allowing explicitly infrastructure-oriented capabilities to remain persistence-free.

Interfacing, Viewing, and Gating are cross-cutting capabilities. Requiring synthetic persistence identities for them would create architecture solely to satisfy tooling rather than a domain responsibility.

## Guardability

Hard for Composer package identity, explicit exemption, expected root Entity path, and declared root class name. Contextual for deciding whether a repository participates in Symfony application composition. Semantic for root-field responsibility and whether an exempt package has acquired a genuine persistence responsibility.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "canonical Symfony component repositories participating in application composition, excluding interfacing/interface, viewing/view, and gating/gate"
  extraction: [composer_package_name, composer_subject_token, expected_root_entity_path, declared_type_kind, declared_type_name]
  body_read: prohibited
  reasoning: none
  escalation: [composition_applicability_ambiguous, composer_identity_parse_failure, root_entity_parse_failure, ambiguous_php_declaration]
  executable_evidence: ["Gating Canon067 repository root Entity findings"]
```
