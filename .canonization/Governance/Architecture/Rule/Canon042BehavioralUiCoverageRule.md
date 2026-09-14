# Canon042BehavioralUiCoverageRule — Functional, Behavioral, and UI Test Coverage Must Be Measurable

## Identity

Canon: `Canon042`
Gating mirror: `Canon042BehavioralUiCoverageRule.php`

## Requirement
Canonical standalone Symfony applications maintain measurable coverage of application behavior in addition to executable PHP code coverage.

This rule does not reinterpret Playwright test counts, Panther test counts, PHPUnit class counts, or raw route counts as coverage. A coverage percentage is valid only when both the tested numerator and the eligible application-surface denominator are explicitly inventoried by a reproducible test-evidence producer.

## Coverage Dimensions

The canonical behavioral/UI coverage evidence contains four independent dimensions:

- `functional`: Symfony application surfaces exercised through application/functional tests;
- `behavioral`: user workflows exercised end-to-end;
- `ui`: interactive user-interface surfaces exercised in a real browser;
- `critical`: workflows explicitly classified as critical and exercised end-to-end.

Each dimension records explicit stable identifiers for the eligible surface inventory and the covered subset. Gating derives `covered` and `total` counters from those inventories; a repository may not supply opaque percentages or unverifiable counters. No dimension may compensate for debt in another.

## Canonical Thresholds

- Functional application-surface coverage: at least **80%**.
- Behavioral workflow coverage: at least **80%**.
- Interactive UI-surface coverage: at least **70%**.
- Critical workflow coverage: **100%**.

## High Behavioral Test Debt

A repository is classified as `HIGH_BEHAVIORAL_TEST_DEBT` when any of the following is true:

- functional coverage is below 50%;
- behavioral coverage is below 50%;
- UI coverage is below 40%;
- critical workflow coverage is below 100%.

The classification is intended for remediation-queue admission. Queue ordering and automatic test-generation policy belong to the execution engine rather than this Canon.

## Canonical Evidence

The executable contract is a persistent repository-local JSON evidence file at `var/coverage/behavioral-ui.json`.

The file is produced by a repository-owned package script and consumed by Gating. Canonical evidence uses schema `behavioral-ui-coverage-v2`, identifies the producing Composer/npm script, records `generatedAt`, and provides explicit `eligible` and `covered` identifier lists for all four dimensions. Gating derives counters from those inventories, rejects duplicate identifiers or covered identifiers outside the denominator, and does not accept legacy counter-only JSON as verified coverage.

Example semantic shape:

```json
{
  "schema": "behavioral-ui-coverage-v2",
  "generatedAt": "2026-09-13T21:00:00-05:00",
  "producer": {
    "kind": "repository_script",
    "script": "test:behavioral-coverage"
  },
  "dimensions": {
    "functional": {"eligible": ["route:retail_new"], "covered": ["route:retail_new"]},
    "behavioral": {"eligible": ["workflow:need_to_order"], "covered": ["workflow:need_to_order"]},
    "ui": {"eligible": ["surface:retail_form"], "covered": ["surface:retail_form"]},
    "critical": {"eligible": ["workflow:checkout"], "covered": ["workflow:checkout"]}
  }
}
```

The producer that establishes the denominator remains repository-owned and intentionally outside Canon042. It may use route inventory, declared workflow manifests, UI action inventories, Playwright metadata/reporters, Panther/PHPUnit metadata, or another deterministic mechanism. The producer script itself must be declared in `composer.json` or `package.json` so another execution can reproduce the evidence path. Canon042 validates the resulting explicit inventories; it does not invent the denominator.

## Missing or Stale Evidence

If Canon041 applies but no valid behavioral/UI coverage evidence exists, Gating reports a warning rather than fabricating a percentage.

If evidence is malformed, internally inconsistent, uses the legacy counter-only shape, references a producer script that is not declared by the repository, or is stale relative to application source/UI files according to `generatedAt`, Gating reports incomplete/invalid evidence.

## Relationship to Framework-Owned Metrics

Symfony application tests remain PHPUnit tests and can contribute to ordinary PHP executable coverage where the executed code is measured by php-code-coverage. Panther and Playwright additionally prove real-browser behavior, but their test execution reports are not themselves an application-surface coverage percentage.

Playwright JSON/JUnit reports are valid execution evidence and may be inputs to the repository-owned evidence producer, but the number of passing Playwright tests is not a canonical UI-coverage denominator.

## Responsibility Boundary

Canon040 owns executable PHP line/method/branch coverage. Canon042 owns behavioral/application-surface coverage evidence. Gating validates the persistent inventories, derives counters, validates provenance/freshness, and applies thresholds but does not invent a proprietary crawler-based coverage metric.

## Guardability

Deterministic runtime warning gate over the canonical behavioral/UI coverage evidence file.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "schema-versioned var/coverage/behavioral-ui.json with declared repository producer, explicit eligible/covered inventories, applicability and generatedAt freshness metadata"
  extraction: [schema, producer_kind, producer_script, generated_at, functional_inventory, behavioral_inventory, ui_inventory, critical_inventory, relevant_source_timestamp]
  body_read: prohibited
  reasoning: none
  escalation: [legacy_or_unknown_schema, undeclared_producer_script, missing_or_malformed_inventory, covered_identifier_outside_denominator, stale_evidence]
  executable_evidence: ["Gating Canon042 inventory-derived counters and provenance verdict"]
```
