# Canon039PhpTestToolingRule — PHP Repositories Require Executable Test Tooling

## Identity

Canon: `Canon039`
Gating mirror: `Canon039PhpTestToolingRule.php`

## Requirement
Every canonical SmartResponsor PHP repository containing executable production PHP code provides an executable PHPUnit testing and code-coverage contract.

The repository declares PHPUnit as a development dependency, owns its PHPUnit configuration, explicitly identifies the production source tree considered for coverage, and exposes reproducible Composer scripts for ordinary test execution and persistent coverage-summary execution.

## Required Dependency
- `phpunit/phpunit` in `composer.json:require-dev`.

## Required Configuration
A repository-owned `phpunit.xml` or `phpunit.xml.dist` must exist.

The PHPUnit configuration must explicitly declare production source considered for coverage. Canonical Symfony-oriented component repositories normally include `src/` through the PHPUnit `<source><include>` configuration.

Coverage configuration must keep uncovered source files in the coverage population. `includeUncoveredFiles="true"` is canonical; omission is also accepted because PHPUnit's default is `true`. Explicit `includeUncoveredFiles="false"` is non-canonical because it can hide completely unexecuted production files.

Branch coverage must be enabled by `branchCoverage="true"` in PHPUnit coverage configuration or by the equivalent `--branch-coverage` / `--path-coverage` execution option.

## Required Execution Contract
Composer scripts must expose both:

- ordinary PHPUnit execution;
- PHPUnit coverage execution that emits a persistent text coverage summary containing line, method/function, and branch totals.

Script names may differ. The executable contract, not one literal script name, is canonical.

## Responsibility Boundary
Canonization does not implement a proprietary test runner or coverage collector. PHPUnit and php-code-coverage own test execution and raw coverage measurement. Gating validates that the standard tooling contract is present, configured, and executable.

## Rationale
Test adequacy must be reproducibly measured by standard industry tooling rather than inferred from test-file counts or custom source scanners. A repository-owned PHPUnit contract also ensures that an agent, CI runner, and developer measure the same production source population.

## Guardability
Hard. Gating validates the PHPUnit development dependency, supported PHPUnit configuration, explicit source coverage population, branch-coverage capability, and Composer execution scripts.
