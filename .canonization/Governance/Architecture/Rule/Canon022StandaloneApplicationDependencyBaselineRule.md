# Canon022StandaloneApplicationDependencyBaselineRule — Standalone Symfony Applications Require the Platform Baseline

## Identity

Canon: `Canon022`
Gating mirror: `Canon022StandaloneApplicationDependencyBaselineRule.php`

## Requirement
Every standalone SmartResponsor Symfony application declares the platform baseline as direct runtime Composer dependencies: `cruding/crud`, `collectioning/collection`, `tabling/table`, `viewing/view`, `interfacing/interface`, `objecting/object`, and `easycorp/easyadmin-bundle`.

## Prohibited
Do not rely on these platform capabilities only transitively through another package, and do not omit one merely because the current application has not yet exercised the corresponding surface.

## Rationale
The baseline makes standalone applications structurally predictable: Cruding provides generic application CRUD; Collectioning provides provider-neutral collection query semantics; Tabling provides backend table-definition contracts and security-aware actions; Viewing provides the view boundary; Interfacing provides shared contracts; Objecting provides shared object identity/infrastructure; and EasyAdmin provides the permitted back-office CRUD surface.

## Standalone Detection
A repository is treated as a standalone Symfony application when it has Symfony application entry/configuration surfaces such as `bin/console` and `config/bundles.php`. Composer `type` alone is not authoritative because SmartResponsor standalone repositories may also identify as Symfony bundles.

## Exceptions
Pure libraries, infrastructure tooling, and non-standalone component packages without Symfony application boot surfaces are outside this baseline unless explicitly promoted to standalone applications.

## Guardability
