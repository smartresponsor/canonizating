# Canon024ProductionComposerBundleRule — Production Uses Packaged Dependencies

## Identity

Canon: `Canon024`
Gating mirror: `Canon024ProductionComposerBundleRule.php`

## Requirement
`composer.prod.json` is the production/container-build manifest. SmartResponsor component dependencies resolve as normal Composer packages/bundles rather than sibling filesystem links.

## Prohibited
Do not declare sibling `path` repositories, `../Component` source paths, or `symlink: true` repositories in `composer.prod.json`.

## Rationale
Production images must be reproducible from packaged dependency artifacts and must not depend on the developer workstation topology.

## Exceptions
None for canonical production dependency resolution. Build tooling may generate package artifacts before Composer resolution, but the production manifest itself remains path-independent.

## Guardability
Hard. Gating validates presence of `composer.prod.json` for canonical SmartResponsor components and rejects path/symlink repositories in that manifest.
