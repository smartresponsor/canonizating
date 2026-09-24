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

`enveloping/envelope` is an optional cross-cutting composition capability, not part of the mandatory standalone dependency baseline. A Host application may install and use Enveloping to attach typed execution context around objects or operations from otherwise standalone consumer components. Consumer components MUST remain valid without Enveloping and MUST NOT be forced to declare it merely because the Host may envelope their values. The `enveloping/envelope` package itself is also exempt from the mandatory application baseline so its standalone debug/runtime surface does not force dependencies on CRUD/UI/domain platform components. Enveloping MUST remain consumer-agnostic and MUST NOT require Host, Shipping, Payment, Messaging, Delivering, Notifying, or other domain repositories merely to enumerate their contextual vocabulary.

## Guardability

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json plus standalone Symfony boot-surface presence"
  extraction: [composer_require_packages, bin_console_presence, bundles_config_presence]
  body_read: prohibited
  reasoning: none
  escalation: [custom_symfony_bootstrap, standalone_applicability_ambiguous]
  executable_evidence: ["Gating Canon022 findings"]
```
