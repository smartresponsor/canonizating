# Canon001TechnicalRoleFirstRule — Technical Role Comes First

## Identity

Canon: `Canon001`
Gating mirror: `Canon001TechnicalRoleFirstRule.php`

## Requirement
Inside `src/`, the first semantic directory must identify the technical role of the PHP type. Business context, family, specialization, or subject comes after that role. Canonical role roots include `Controller/`, `Service/`, `ServiceInterface/`, `Repository/`, `RepositoryInterface/`, `Entity/`, `DTO/`, `Form/`, `FormInterface/`, `Policy/`, `Builder/`, `BuilderInterface/`, `Responder/`, `Command/`, `Enum/`, `Event/`, `Snapshot/`, and `ValueObject/`.

## Prohibited
Do not use business-subject-first trees that hide the technical role behind an early context directory.

## Rationale
Symfony-oriented component trees must reveal what an object is before what business context it serves.

## Good example
`src/Service/Invoice/InvoiceCalculator.php`

## Bad example
`src/Invoice/Service/InvoiceCalculator.php`

## Exceptions
No general subject-first exception is accepted. Infrastructure exceptions must be explicitly documented elsewhere in the canon.

## Guardability
Hard for approved role roots; semantic where a repository introduces a legitimate new role root.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all paths below src/"
  extraction: [relative_path, first_semantic_directory]
  body_read: prohibited
  reasoning: candidates_only
  escalation: [unknown_role_root, framework_required_root_not_in_canon]
  executable_evidence: ["Gating Canon001 findings"]
```
