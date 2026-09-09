# Canon003DtoIsExplicitRule — DTO Is Explicit

## Identity

Canon: `Canon003`
Gating mirror: `Canon003DtoIsExplicitRule.php`

## Requirement
A Data Transfer Object must live under `src/DTO/`, use exact `DTO` casing, and use `DTO` as both filename and declared-type suffix. Meaningful semantic qualifiers such as `Summary`, `Readiness`, `Diagnostics`, `View`, `Row`, or `Eligibility` should be preserved.

## Prohibited
Do not use `src/Dto/`, omit the DTO suffix, or disguise DTOs with vague replacements such as `Data`, `Payload`, or `Result`. Avoid empty phrases such as `DataDTO` when `Data` adds nothing.

## Rationale
Transport objects must be mechanically and visually distinguishable from entities, value objects, messages, and services.

## Good examples
`src/DTO/ApplicationSummaryDTO.php`, `ApplicationManifestDTO`.

## Bad examples
`src/Dto/ApplicationSummary.php`, `ApplicationSummaryData`, `ApplicationSummaryPayload`, `ApplicationManifestDataDTO` when these objects are DTOs.

## Exceptions
A genuine ValueObject, Entity, message contract, or view model must keep its actual technical role instead of being renamed to DTO for uniformity.

## Guardability
Hard for path/casing/suffix consistency; semantic for classifying arbitrary `Payload`, `Data`, or `Result` objects.
