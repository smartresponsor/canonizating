# Canon021CrudingOwnsGenericCrudRule — Cruding Owns Generic Application CRUD

## Identity

Canon: `Canon021`
Gating mirror: `Canon021CrudingOwnsGenericCrudRule.php`

## Requirement
Generic application CRUD routing and processing belongs to the `Cruding` component (`cruding/crud`). A standalone component supplies its component-specific semantics and configuration instead of implementing a parallel generic CRUD engine.

## Prohibited
Do not create component-local generic CRUD controllers, generic CRUD route builders, generic CRUD routers, or generic CRUD services that duplicate the platform capability owned by Cruding.

## Rationale
Duplicating generic CRUD across components fragments one platform capability into incompatible local implementations and prevents fixes and policy changes from propagating centrally.

## Exceptions
EasyAdmin CRUD controllers and routes used for administrative/back-office surfaces are explicitly allowed in standalone applications. They are an admin UI surface and do not compete with Cruding's generic application CRUD ownership. Component-specific non-generic operations are also allowed.

## Guardability
Semantic with hard candidates. Gating may flag local `*Crud*` machinery outside Cruding while suppressing EasyAdmin-derived/configured CRUD surfaces.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all non-Cruding PHP declarations, routes, and CRUD-named configuration surfaces"
  extraction: [relative_path, declared_type_name, crud_vocabulary, route_names, route_paths, extends_implements]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [crud_candidate_not_easyadmin, generic_vs_business_operation_ambiguous, route_ownership_ambiguous]
  executable_evidence: ["Gating Canon021 candidates"]
```
