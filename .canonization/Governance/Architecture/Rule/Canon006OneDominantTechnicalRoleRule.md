# Canon006OneDominantTechnicalRoleRule — One Class Has One Dominant Technical Role

## Identity

Canon: `Canon006`
Gating mirror: `Canon006OneDominantTechnicalRoleRule.php`

## Requirement
Class name and filesystem location must express one dominant technical role. First-class roles such as Builder, Responder, Policy, Repository, or Service must use their own role suffix and role tree.

## Prohibited
Do not hide first-class builders/responders/policies in `Service/`, combine technical-role suffixes merely as taxonomy workarounds, or place a class in a tree that contradicts its role suffix.

## Rationale
The dominant role should be visible before implementation details are read, preventing `Service/` from becoming a generic application-code bucket.

## Good examples
`Builder/Listing/FacetListingCriteriaBuilder.php`, `Responder/Api/FacetResponder.php`, `Policy/Access/FacetAccessPolicy.php`.

## Bad examples
`FacetingListingCriteriaBuilderService`, `OfferResponderService`, `GatewayAdapterService` when the compound name only hides a first-class role.

## Exceptions
Compound names are allowed when the compound responsibility is real and evidenced by behavior/usage, not naming preference.

## Guardability
Semantic with hard checks for known conflicting suffix/path combinations.
