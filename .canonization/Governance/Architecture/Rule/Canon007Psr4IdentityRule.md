# Canon007Psr4IdentityRule — PSR-4 Identity Is Literal

## Identity

Canon: `Canon007`
Gating mirror: `Canon007Psr4IdentityRule.php`

## Requirement
Filesystem path, namespace, filename, and declared PHP type must agree exactly under the repository's PSR-4 mapping. A rename or move is incomplete until imports, usages, configuration, and metadata references are synchronized.

## Prohibited
Do not leave namespace/path mismatches, filename/declaration mismatches, stale imports, or compatibility aliases after a completed migration without an explicit compatibility requirement.

## Rationale
Literal PSR-4 identity makes repository structure mechanically verifiable and prevents hidden legacy topology.

## Good example
`src/Service/Payment/PaymentService.php`, namespace `App\\Service\\Payment`, class `PaymentService`.

## Bad example
The same path with namespace `App\\Payment\\Service` or class `PayService`.

## Exceptions
Explicit compatibility surfaces may exist only when compatibility is an active requirement with a defined lifecycle.

## Guardability
Hard.
