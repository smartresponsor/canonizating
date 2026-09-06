# Canon029MandatoryPhpQualityToolingRule — PHP Components Require Standard Quality Tooling

## Identity

Canon: `Canon029`
Gating mirror: `Canon029MandatoryPhpQualityToolingRule.php`

## Requirement
Every canonical SmartResponsor PHP repository declares PHP-CS-Fixer and PHPStan as development dependencies, provides explicit repository-owned configuration for both tools, and exposes reproducible Composer scripts that run formatting checks/fixes and static analysis.

## Required Dependencies
- `friendsofphp/php-cs-fixer` in `composer.json:require-dev`.
- `phpstan/phpstan` in `composer.json:require-dev`.

## Required Configuration
PHP-CS-Fixer configuration must be repository-visible, canonically `.php-cs-fixer.dist.php` or `.php-cs-fixer.php`. PHPStan configuration must be repository-visible through a supported root or quality-tree config such as `phpstan.neon`, `phpstan.neon.dist`, `phpstan.dist.neon`, or `.gating/quality/**/phpstan.neon`.

## Required Execution Contract
Composer scripts must expose a PHP-CS-Fixer check/fix path and a PHPStan analysis path. Script names may differ, but the commands must invoke `php-cs-fixer` and `phpstan` respectively.

## Rationale
Canonization does not duplicate formatter or static-analysis rules. It guarantees that the standard industry tools responsible for those concerns are present, configured, and executable in every PHP repository.

## Guardability
Hard. Gating validates dev dependencies, discovers supported config files, and inspects Composer scripts for executable PHP-CS-Fixer and PHPStan commands.
