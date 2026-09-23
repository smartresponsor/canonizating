# Canon053SiblingComposerSymlinkIsolationRule — Sibling Composer Symlinks Are Closed

## Identity

Canon: `Canon053`
Gating mirror: `Canon053SiblingComposerSymlinkIsolationRule.php`

## Requirement

A canonical component's development `composer.json` must not expose symlinked sibling component repositories except for the ten canonical infrastructure/foundation/helper exceptions:

- `../Gating`
- `../Cruding`
- `../Viewing`
- `../Interfacing`
- `../Collectioning`
- `../Objecting`
- `../Tabling`
- `../Runtime`
- `../Indexing`
- `../Discovering`

This rule is intentionally negative and atomic. It does not require any exception to be present, does not classify component roles, and does not inspect PHP code, the Symfony container, runtime service graphs, or transitive package semantics.

## Prohibited

Do not add a Composer `path` repository with `options.symlink: true` to any other sibling component. In particular, one capability component must not be coupled to another capability component through a local development symlink.

## Rationale

The local symlink contour is a deterministic representation of direct cross-repository development coupling. Keeping that contour closed prevents capability components from gradually absorbing sibling responsibilities while remaining automatically scalable as new components are added: new component names do not need to be catalogued by Gating.

## Exceptions

Only `Gating`, `Cruding`, `Viewing`, `Interfacing`, `Collectioning`, `Objecting`, `Tabling`, `Runtime`, `Indexing`, and `Discovering` are exempt. The exception list is deliberately explicit and canonical.

This rule does not assert that an exception must exist. Presence/installation requirements belong to their own independent rules.

## Guardability

Hard. Gating reads only the development `composer.json` repositories section and rejects local sibling `path` repositories whose `options.symlink` value is `true` unless their sibling directory is one of the ten exceptions.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json repositories section only"
  extraction: [repository_type, repository_url, options_symlink]
  body_read: prohibited
  reasoning: none
  escalation: [noncanonical_local_symlink]
  executable_evidence: ["Gating Canon053 findings"]
```
