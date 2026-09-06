# Canon032BundleRegistrationRule — Reusable Bundle Must Be Registered in Standalone Mode

## Requirement
Every dual-mode SmartResponsor Symfony component that exposes a reusable `src/*Bundle.php` surface must register that bundle in its standalone application bundle configuration.

The registration surface may be the conventional `config/bundles.php` or a component-owned equivalent loaded by its Kernel. File naming is not canonical; actual registration is.

## Invariant
`component bundle class -> standalone bundle configuration -> enabled bundle instance`.

Having a decorative Bundle class that is never registered by standalone mode is non-canonical.

## Guardability
Hard. Gating resolves `src/*Bundle.php` identities and verifies registration through Kernel/component PHP bundle configuration.

## Rationale
Dual runtime mode requires the reusable bundle surface to be executable architecture, not merely a packaging artifact.
