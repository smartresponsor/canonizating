# Canon053SiblingComposerSymlinkIsolationRule — Sibling Composer Symlinks Are Closed

## Identity

Canon: `Canon053`
Gating mirror: `Canon053SiblingComposerSymlinkIsolationRule.php`

## Requirement

This rule applies to canonical components, but not to the root composition host package `smartresponsing/app`.

The App host is the platform aggregator. Its development `composer.json` may expose symlinked sibling repositories for both infrastructure/foundation/helper components and product/capability components that it composes into the runtime.

For every other canonical component, development `composer.json` must not expose symlinked sibling component repositories except for the thirteen canonical infrastructure/foundation/helper exceptions:

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
- `../Administering`
- `../Accessing`
- `../Configuring`

This rule is intentionally negative and atomic. Applicability is determined only by the Composer package identity: `smartresponsing/app` is excluded. For all other packages, it does not require any exception to be present, does not classify component roles, and does not inspect PHP code, the Symfony container, runtime service graphs, or transitive package semantics.

## Prohibited

Do not add a Composer `path` repository with `options.symlink: true` to any other sibling component. In particular, one capability component must not be coupled to another capability component through a local development symlink.

## Rationale

The local symlink contour is a deterministic representation of direct cross-repository development coupling. Keeping that contour closed prevents capability components from gradually absorbing sibling responsibilities while remaining automatically scalable as new components are added: new component names do not need to be catalogued by Gating.

## Exceptions

The package `smartresponsing/app` is exempt from this rule because it is the root composition host.

For every other package, only `Gating`, `Cruding`, `Viewing`, `Interfacing`, `Collectioning`, `Objecting`, `Tabling`, `Runtime`, `Indexing`, `Discovering`, `Administering`, `Accessing`, and `Configuring` are exempt sibling symlinks. The exception list is deliberately explicit and canonical.

This rule does not assert that an exception must exist. Presence/installation requirements belong to their own independent rules.

## Guardability

Hard. Gating reads the development `composer.json` package name and repositories section. It skips `smartresponsing/app`; for every other package it rejects local sibling `path` repositories whose `options.symlink` value is `true` unless their sibling directory is one of the thirteen exceptions.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json package name and repositories section only"
  extraction: [package_name, repository_type, repository_url, options_symlink]
  body_read: prohibited
  reasoning: none
  escalation: [noncanonical_local_symlink]
  executable_evidence: ["Gating Canon053 findings"]
```
