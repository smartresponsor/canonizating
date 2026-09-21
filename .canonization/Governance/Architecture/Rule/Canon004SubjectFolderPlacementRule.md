# Canon004SubjectFolderPlacementRule — Subject Folder Placement Must Not Be Premature

## Identity

Canon: `Canon004`
Gating mirror: `Canon004SubjectFolderPlacementRule.php`

## Requirement
In ordinary technical trees, a component/subject token such as `Facet`, `Case`, `Cart`, or `Catalog` must not be introduced as a directory before the fourth path level when `src` is level one. The rule applies to directories, not the terminal class name.

Good: `src/Service/Management/Facet/...`.
Bad: `src/Service/Facet/...`, `src/Form/Facet/...`, or redundant `src/Service/Faceting/...`.

Flat terminal classes such as `src/Entity/Facet.php` and `src/Enum/FacetType.php` remain valid. Do not add meaningless directories merely to reach numeric depth.

## Rationale
The repository already supplies component context. Repeating the component too early competes with technical-role-first topology.

## E1 — Entity infrastructure exception
`src/Entity/<DomainToken>/<EntityClass>.php` is the only currently accepted early domain-folder exception because multiple Doctrine connections/entity managers, mappings, and aliases can require one mapping/domain token directly below `Entity/`. The token is the Doctrine/entity-domain grouping (for example `Entity/Attachment/`), not an architectural layer such as `Persistence`. Entity paths must not introduce another directory below that domain token: `src/Entity/<DomainToken>/<Direction>/<EntityClass>.php` is non-canonical. Flat terminal entities such as `src/Entity/Facet.php` remain valid. This exception does not extend to `Service`, `Form`, `DTO`, `Repository`, `Policy`, `Builder`, `Responder`, or other technical roots.

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
