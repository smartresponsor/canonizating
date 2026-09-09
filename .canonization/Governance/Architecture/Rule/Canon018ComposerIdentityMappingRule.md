# Canon018ComposerIdentityMappingRule — Composer Name Defines Component and Subject Identity

## Identity

Canon: `Canon018`
Gating mirror: `Canon018ComposerIdentityMappingRule.php`

## Requirement
For a canonical SmartResponsor component package, Composer `name` is `<component-token>/<subject-token>`. The first token defines component identity and maps to the PSR-4 namespace root `App\\<ComponentToken>\\ => src/`. The second token defines the canonical PHP subject vocabulary and maps to the Studly subject prefix used by component-owned PHP types.

## Prohibited
Do not swap the two tokens, use the subject token as the component namespace root, or derive the subject token mechanically by trimming `-ing` from the component token. `cataloging/catalog` means `App\\Cataloging\\` plus `Catalog*`; `faceting/facet` means `App\\Faceting\\` plus `Facet*`.

## Rationale
Composer sees vendor/package syntax only; SmartResponsor assigns architectural meaning to both positions. Keeping both identities explicit prevents namespace identity and PHP subject vocabulary from drifting together.

## Exceptions
Framework bootstrap types whose canonical names are imposed by Symfony conventions, such as a root `Kernel`, are not subject-prefix types. Non-component tooling packages that do not use an `App\\<Component>\\ => src/` mapping are outside this rule.

## Guardability
Hard. Gating derives both expected identities directly from `composer.json:name` and verifies the PSR-4 mapping plus subject-prefixed component types without a duplicate profile vocabulary.
