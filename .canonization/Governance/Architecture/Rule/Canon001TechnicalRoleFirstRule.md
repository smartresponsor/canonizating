# Canon001TechnicalRoleFirstRule — Technical Role Comes First

## Identity

Canon: `Canon001`
Gating mirror: `Canon001TechnicalRoleFirstRule.php`

## Requirement
Inside `src/`, the first semantic directory must identify the technical role of the PHP type. Business context, family, specialization, or subject comes after that role. This rule defines only the first semantic token; subsequent subject placement remains constrained by Canon004. In ordinary technical trees, a component/subject token must therefore not be placed immediately below the technical-role root merely because Canon001 has already been satisfied. Canonical role roots include `Controller/`, `Service/`, `ServiceInterface/`, `Repository/`, `RepositoryInterface/`, `Entity/`, `DTO/`, `Form/`, `FormInterface/`, `Policy/`, `Builder/`, `BuilderInterface/`, `Responder/`, `Command/`, `Enum/`, `Event/`, `Snapshot/`, `Voter/`, `VoterInterface/`, `ValueObject/`, and other explicit technical-role roots such as `Accessor/`, `Cache/`, `Configurator/`, `Discovery/`, `Extractor/`, `Filter/`, `Formatter/`, `Generator/`, `Inspector/`, `Reader/`, `Renderer/`, `Scorer/`, `Stringifier/`, `Workflow/`, and `Writer/`. The list is not a closed catalog; an unknown root is an escalation candidate, not evidence by itself that the tree is business-subject-first.

## Prohibited
Do not use business-subject-first trees that hide the technical role behind an early context directory.

## Rationale
Symfony-oriented component trees must reveal what an object is before what business context it serves.

## Platform example
For repository/component `Cruding`, the configured subject token is `Crud`.

Canonical existing form, with the subject carried by the terminal class rather than repeated as a directory:
`src/Service/Operation/CrudApiCreateOperation.php`

Canonical grouped form when an explicit subject directory is genuinely useful:
`src/Service/Operation/Crud/CrudApiCreateOperation.php`

Here `Service` is the technical role, `Operation` is the technical direction, `Crud` is the optional component subject directory, and `CrudApiCreateOperation` is the terminal type.

## Bad examples
`src/Crud/Service/CrudApiCreateOperation.php` is subject-first.

`src/Service/Crud/CrudApiCreateOperation.php` introduces the `Crud` subject directory too early; Canon004 requires a meaningful technical direction before it.

The repository name `Cruding` is not itself a directory requirement. Repository/component identity, configured subject token, technical role, technical direction, and terminal type are distinct concepts.

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
