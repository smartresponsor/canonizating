# Canon022StandaloneApplicationDependencyBaselineRule — Standalone Symfony Applications Require the Platform Baseline

## Identity

Canon: `Canon022`
Gating mirror: `Canon022StandaloneApplicationDependencyBaselineRule.php`

## Requirement
Every standalone platform Symfony application declares the platform baseline as direct runtime Composer dependencies in both `composer.json` and `composer.prod.json`: `cruding/crud`, `collectioning/collection`, `tabling/table`, `viewing/view`, `interfacing/interface`, `objecting/object`, `failing/failure`, and `easycorp/easyadmin-bundle`.

When the standalone application is itself one of those first-party baseline packages, its own Composer package name is excluded from the required dependency set. A package MUST NOT require itself merely to satisfy the baseline.

Because Failing owns executable Symfony runtime integration, standalone consumers also register `App\\Failing\\FailingBundle` in `config/bundles.php`. Development resolution remains governed by Canon023/043/045 (`../Failing`, `symlink: true`, `dev-master`, and repository closure); production resolution remains governed by Canon024 and therefore must not use a local path/symlink repository.

## Prohibited
Do not rely on these platform capabilities only transitively through another package, and do not omit one merely because the current application has not yet exercised the corresponding surface.

## Rationale
The baseline makes standalone applications structurally predictable: Cruding provides generic application CRUD; Collectioning provides provider-neutral collection query semantics; Tabling provides backend table-definition contracts and security-aware actions; Viewing provides the view boundary; Interfacing provides shared contracts; Objecting provides shared object identity/infrastructure; Failing provides the shared public-failure declaration, resolution, and deterministic operation-inventory runtime; and EasyAdmin provides the permitted back-office CRUD surface.

## Standalone Detection
A repository is treated as a standalone Symfony application when it has Symfony application entry/configuration surfaces such as `bin/console` and `config/bundles.php`. Composer `type` alone is not authoritative because platform standalone repositories may also identify as Symfony bundles.

## Exceptions
Pure libraries, infrastructure tooling, and non-standalone component packages without Symfony application boot surfaces are outside this baseline unless explicitly promoted to standalone applications.

`enveloping/envelope` is an optional cross-cutting composition capability, not part of the mandatory standalone dependency baseline. A Host application may install and use Enveloping to attach typed execution context around objects or operations from otherwise standalone consumer components. Consumer components MUST remain valid without Enveloping and MUST NOT be forced to declare it merely because the Host may envelope their values. The `enveloping/envelope` package itself is also exempt from the mandatory application baseline so its standalone debug/runtime surface does not force dependencies on CRUD/UI/domain platform components. Enveloping MUST remain consumer-agnostic and MUST NOT require Host, Shipping, Payment, Messaging, Delivering, Notifying, or other domain repositories merely to enumerate their contextual vocabulary.

## Guardability

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json, composer.prod.json, and standalone Symfony boot/bundle-registration surfaces"
  extraction: [development_require_packages, production_require_packages, bin_console_presence, bundles_config_presence, failing_bundle_registration]
  body_read: prohibited
  reasoning: none
  escalation: [custom_symfony_bootstrap, standalone_applicability_ambiguous]
  executable_evidence: ["Gating Canon022 findings"]
```
