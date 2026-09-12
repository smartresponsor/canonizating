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

Each dimension records `covered` and `total` counts. No dimension may compensate for debt in another.

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

The file is produced by the repository's test/coverage workflow and consumed by Gating. It must contain integer `covered` and `total` counters for all four dimensions. Gating must not infer those counters by counting test files, test methods, routes, controllers, DOM nodes, or Playwright specs.

Example semantic shape:

```json
{
  "functional": {"covered": 8, "total": 10},
  "behavioral": {"covered": 4, "total": 5},
  "ui": {"covered": 7, "total": 10},
  "critical": {"covered": 3, "total": 3}
}
```

The producer that establishes the denominator is intentionally outside Canon042. It may use route inventory, declared workflow manifests, UI action inventories, Playwright metadata/reporters, Panther/PHPUnit metadata, or another deterministic repository-owned mechanism. What is canonical is that the resulting counters are explicit, reproducible, and not guessed by Gating.

## Missing or Stale Evidence

If Canon041 applies but no valid behavioral/UI coverage evidence exists, Gating reports a warning rather than fabricating a percentage.

If evidence is malformed, internally inconsistent, or stale relative to application source/UI files, Gating reports incomplete/invalid evidence.

## Relationship to Framework-Owned Metrics

Symfony application tests remain PHPUnit tests and can contribute to ordinary PHP executable coverage where the executed code is measured by php-code-coverage. Panther and Playwright additionally prove real-browser behavior, but their test execution reports are not themselves an application-surface coverage percentage.

Playwright JSON/JUnit reports are valid execution evidence and may be inputs to the repository-owned evidence producer, but the number of passing Playwright tests is not a canonical UI-coverage denominator.

## Responsibility Boundary

Canon040 owns executable PHP line/method/branch coverage. Canon042 owns behavioral/application-surface coverage evidence. Gating validates the persistent counters and thresholds but does not invent a proprietary crawler-based coverage metric.

## Guardability

Deterministic runtime warning gate over the canonical behavioral/UI coverage evidence file.
