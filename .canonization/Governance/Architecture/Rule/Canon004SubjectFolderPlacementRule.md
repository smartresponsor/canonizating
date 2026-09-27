# Canon004SubjectFolderPlacementRule — Subject Folder Placement Must Not Be Premature

## Identity

Canon: `Canon004`
Gating mirror: `Canon004SubjectFolderPlacementRule.php`

## Requirement
In ordinary technical trees, a configured component subject token must not be introduced as a directory before the fourth path level when `src` is level one. The rule applies to directory tokens, not to a subject prefix carried by the terminal class name.

For repository/component `Cruding`, the platform profile declares `Crud` as the subject token. Therefore:

- canonical existing form: `src/Service/Operation/CrudApiCreateOperation.php` — no `Crud` subject directory is introduced;
- canonical grouped form: `src/Service/Operation/Crud/CrudApiCreateOperation.php` — `Crud` appears at level four after the meaningful `Operation` direction;
- non-canonical: `src/Service/Crud/CrudApiCreateOperation.php` — `Crud` appears at level three;
- non-canonical: `src/Crud/Service/CrudApiCreateOperation.php` — the subject precedes the technical role.

For repository/component `Carting`, the same distinction is `Carting` (repository/component identity) versus `Cart` (configured subject token). The rule never derives subject vocabulary by mechanically trimming `-ing`.

Flat terminal classes outside the Entity technical root, such as `src/Enum/CrudOperation.php`, remain valid because `Crud` is part of the terminal class rather than a directory token. A terminal persistence class under `src/Entity/` must use the `Entity` suffix. Do not add meaningless directories merely to reach numeric depth.

## Rationale
The repository already supplies component context. Repeating the component too early competes with technical-role-first topology.

## E1 — Entity infrastructure exception
`src/Entity/<DomainToken>/<EntityClass>.php` is the only currently accepted early domain-folder exception because multiple Doctrine connections/entity managers, mappings, and aliases can require one mapping/domain token directly below `Entity/`. The token is the Doctrine/entity-domain grouping (for example `Entity/Attachment/`), not an architectural layer such as `Persistence`. The terminal Doctrine entity class and filename must end with `Entity`, so canonical examples are `src/Entity/Attachment/AttachmentEntity.php` and `src/Entity/Attachment/AttachmentLinkEntity.php`. Entity paths must not introduce another directory below that domain token: `src/Entity/<DomainToken>/<Direction>/<EntityClass>.php` is non-canonical. Flat entities remain valid only with the same suffix, for example `src/Entity/FacetEntity.php`. This exception does not extend to `Service`, `Form`, `DTO`, `Repository`, `Policy`, `Builder`, `Responder`, or other technical roots.

## E2 — Natural component vocabulary
Use platform vocabulary rather than mechanical stemming: `Faceting -> Facet`, `Cataloging -> Catalog`, `Carting -> Cart`. Natural words such as `Billing` must not be forced into `Bill`. A redundant `src/Service/Billing/...` bucket inside Billing is still non-canonical if it adds no distinction.

## Guardability
Hard with a component vocabulary profile and explicit Entity exception; semantic for judging legitimate contextual meaning.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all src/ directory paths"
  extraction: [relative_path, directory_tokens, component_subject_identity, technical_role_root]
  body_read: prohibited
  reasoning: candidates_only
  escalation: [early_subject_token_with_possible_semantic_context, entity_infrastructure_exception_candidate]
  executable_evidence: ["Gating Canon004 findings"]
```
