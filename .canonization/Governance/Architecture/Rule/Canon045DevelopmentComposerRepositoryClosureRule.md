# Canon045DevelopmentComposerRepositoryClosureRule — Root Composer Declares Local Dependency Closure

## Identity

Canon: `Canon045`
Gating mirror: `Canon045DevelopmentComposerRepositoryClosureRule.php`

## Requirement
In development, the root `composer.json` must declare local Composer `path` repositories for the complete first-party runtime dependency closure needed by locally linked sibling packages.

Composer reads repository definitions only from the root package. Repository declarations inside dependency packages are not inherited. Therefore, when a locally linked first-party package requires another first-party package that it itself locates through a sibling `path` repository, the root consumer must also expose that transitive sibling as a root `path` repository.

The transitive package does not become a direct root `require` dependency solely because its repository must be visible. Direct dependency ownership remains governed by the actual runtime coupling and other canon rules.

## Prohibited
Do not rely on a dependency package's own `repositories` section to make its transitive first-party dependencies discoverable from a root consumer. Do not duplicate a transitive package into `require` merely to work around repository discovery when there is no direct runtime dependency.

## Rationale
Composer intentionally ignores repository declarations from dependencies. Without root repository closure, an otherwise valid local dependency graph can resolve on one package in isolation but fail when consumed by another component. Explicit root closure makes local development deterministic and keeps first-party package resolution reproducible.

## Good example
Tagging requires Cruding. Cruding requires Collectioning and Tabling and declares local paths for them. Tagging also declares root `path` repositories for Collectioning and Tabling, while leaving them out of Tagging `require` unless Tagging directly depends on them.

## Bad example
Tagging declares only a path repository for Cruding and expects Cruding's own `repositories` section to make Collectioning and Tabling visible to Composer.

## Exceptions
Third-party repositories and production package distribution are outside this development-local rule. A transitive package that is resolved from an authoritative non-path repository available to the root does not require an additional local path repository.

## Guardability
Hard. Gating can traverse locally linked sibling package manifests, inspect their runtime `require` edges and sibling path repositories, compute the reachable first-party local repository closure, and verify that every required reachable sibling path is also declared by the root development manifest.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "development composer.json root path repositories and reachable first-party sibling runtime dependency closure"
  extraction: [root_composer_path, root_path_repository, sibling_package_name, runtime_require_edge, transitive_path_repository]
  body_read: prohibited
  reasoning: none
  escalation: [unresolvable_local_path, invalid_sibling_composer_manifest]
  executable_evidence: ["Gating Canon045 findings"]
```
