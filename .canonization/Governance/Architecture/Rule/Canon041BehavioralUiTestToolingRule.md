# Canon041BehavioralUiTestToolingRule — Symfony Applications Require Functional, Browser, and UI Test Tooling

## Identity

Canon: `Canon041`
Gating mirror: `Canon041BehavioralUiTestToolingRule.php`

## Requirement
Canonical standalone Symfony applications must provide an executable multi-layer test tooling contract for functional/application, browser end-to-end, and UI end-to-end testing.

The contract complements Canon039 rather than replacing it. Canon039 continues to own PHPUnit and php-code-coverage. Canon041 adds the standard Symfony and browser testing layers used to exercise user-visible application behavior.

## Required PHP Development Dependencies

- `symfony/test-pack` in `composer.json:require-dev` for the standard Symfony application-testing stack used by `WebTestCase` and related BrowserKit assertions.
- `symfony/panther` in `composer.json:require-dev` for real-browser Symfony end-to-end testing.

`phpunit/phpunit` remains independently required by Canon039.

## Required JavaScript Development Dependency

- `@playwright/test` in `package.json:devDependencies`.

The Playwright dependency must be repository-local. A globally installed Playwright binary or transitive dependency does not satisfy the contract.

## Required Configuration and Execution Contract

The repository must own a Playwright configuration file using one of the supported conventional names: `playwright.config.ts`, `playwright.config.js`, `playwright.config.mts`, `playwright.config.mjs`, `playwright.config.cts`, or `playwright.config.cjs`.

Repository scripts must expose reproducible execution paths for PHPUnit/Symfony application tests and Playwright tests. Panther tests may share the ordinary PHPUnit execution path because `PantherTestCase` is a PHPUnit test surface; a separate Panther-specific script is optional.

Script names are not canonical. The executable contract is canonical.

## Applicability

This rule applies to standalone Symfony applications identified by normal Symfony boot/runtime surfaces or by a direct `symfony/framework-bundle` dependency.

Pure non-Symfony PHP libraries and repositories without a Symfony application runtime are outside this rule and are skipped.

## Responsibility Boundary

Canonization does not implement a proprietary functional-test or browser-test runner. Symfony/PHPUnit, Panther, and Playwright own execution semantics. Gating verifies that the standard tooling dependencies, configuration, and runnable repository scripts are present.

## Rationale

Executable PHP code coverage alone cannot demonstrate that routing, forms, security, JavaScript behavior, browser interactions, and user-visible workflows are exercised. A canonical repository therefore carries the standard tools needed to test each of those layers directly.

## Guardability

Hard. Gating can deterministically verify the required Composer and npm development dependencies, Playwright configuration, Symfony applicability, and repository execution scripts.
