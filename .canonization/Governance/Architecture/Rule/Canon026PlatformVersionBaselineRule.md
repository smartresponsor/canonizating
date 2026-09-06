# Canon026PlatformVersionBaselineRule — Platform Uses Modern PHP and Symfony 8

## Identity

Canon: `Canon026`
Gating mirror: `Canon026PlatformVersionBaselineRule.php`

## Requirement
The platform baseline is PHP 8.4 or newer and Symfony 8.1 or newer within the Symfony 8 major line. Repositories should track the current maintained Symfony 8.x branch rather than remain on an unmaintained minor.

## Prohibited
Do not declare PHP constraints that permit versions below 8.4 or Symfony runtime/framework constraints that permit Symfony below 8.1 for canonical platform components.

## Rationale
Symfony 8 requires PHP 8.4+, and the platform intentionally targets the modern Symfony 8 line rather than compatibility with older majors.

## Evolution
The floor may move upward as newer maintained Symfony 8.x minors become the platform baseline; the Canon identity remains stable while the executable baseline is updated deliberately.

## Guardability
Hard for Composer constraints; current baseline: PHP `>=8.4`, Symfony `>=8.1` and `<9`.
