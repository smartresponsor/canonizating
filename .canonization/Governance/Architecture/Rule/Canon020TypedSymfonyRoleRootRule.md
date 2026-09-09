# Canon020TypedSymfonyRoleRootRule — Symfony Extension Types Live in Explicit Technical Role Roots

## Identity

Canon: `Canon020`
Gating mirror: `Canon020TypedSymfonyRoleRootRule.php`

## Requirement
Symfony and application extension types are placed under explicit technical role roots such as `Controller`, `Command`, `Form`, `Voter`, `Subscriber`, `Listener`, `Repository`, `Service`, `Resolver`, `Provider`, `Handler`, `Normalizer`, and corresponding typed interface roots when applicable.

## Prohibited
Do not hide stable typed responsibilities under generic roots such as `Common`, `Core`, `Support`, `Runtime`, `Infrastructure`, `Utility`, or `Helper` merely to avoid choosing the actual technical role.

## Rationale
Symfony autoconfiguration can discover many class locations, so framework validity does not guarantee platform-canonical topology. The role must remain visible in the first structural token.

## Exceptions
True framework/bootstrap roots with their own stable technical meaning, such as `Kernel`, `DependencyInjection`, or bundle metadata, may remain where Symfony integration requires them.

## Guardability
Hard for known generic root folders and known suffix/root mismatches; semantic for newly invented generic buckets.
