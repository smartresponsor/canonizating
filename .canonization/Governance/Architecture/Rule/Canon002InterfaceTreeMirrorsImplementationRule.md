# Canon002InterfaceTreeMirrorsImplementationRule — Interface Tree Mirrors Implementation Tree

## Identity

Canon: `Canon002`
Gating mirror: `Canon002InterfaceTreeMirrorsImplementationRule.php`

## Requirement
When a technical role has a dedicated interface category, the interface path must mirror the implementation path after role-root substitution: `Service/ <-> ServiceInterface/`, `Repository/ <-> RepositoryInterface/`, `Builder/ <-> BuilderInterface/`.

## Prohibited
Do not place typed-role interfaces in generic `Contract/` merely because they are interfaces, do not place concrete services/registries in interface buckets, and do not let implementation/interface context paths drift apart.

## Rationale
Mirrored trees make implementation/contract pairs predictable and avoid a second arbitrary taxonomy.

## Good example
`src/Service/Payment/FooService.php` and `src/ServiceInterface/Payment/FooServiceInterface.php`.

## Bad example
`src/Service/Payment/FooService.php` with `src/Contract/FooServiceInterface.php` when `Contract/` adds no distinct semantics.

## Exceptions
`Contract/` is not globally forbidden. It is valid for a genuinely homogeneous family of runtime/behavior contracts that does not belong to an existing typed interface role.

## Guardability
Hard where pairing is discoverable; semantic for standalone contracts.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all typed implementation and interface role paths"
  extraction: [relative_path, technical_role_root, declaration_name, mirror_relative_path]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [standalone_contract_without_pair, ambiguous_role_family, declaration_parse_failure]
  executable_evidence: ["Gating Canon002 findings"]
```
