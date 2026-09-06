# Canon000ComponentPrefixRule — Component PHP Subject Prefix Is Mandatory

## Identity

Canon: `Canon000`
Gating mirror: `Canon000ComponentPrefixRule.php`

## Requirement
PHP classes and interfaces owned by a component must use that component's established subject prefix. Repository/component identifiers and PHP subject prefixes are related but distinct vocabulary layers. For process-style component names, PHP names normally use the natural subject form: `Faceting -> Facet*`, `Cataloging -> Catalog*`, `Carting -> Cart*`. Technical roles are normally suffixes such as `DTO`, `Service`, `Repository`, `Interface`, `Builder`, `Responder`, or `Policy`.

## Prohibited
Do not mechanically copy the process repository name into every PHP class, do not mechanically strip `-ing` when that produces unnatural vocabulary, and do not allow competing subject prefixes without an explicit platform vocabulary decision.

## Rationale
The repository name identifies the capability/process while the PHP type name identifies a subject inside that capability.

## Good examples
`FacetRepository`, `FacetService`, `FacetListingCriteriaDTO`, `CatalogRepositoryInterface`, `CartService`.

## Bad examples
`FacetingRepository`, `CatalogingService`, `FacetingListingCriteriaBuilderService`.

## Exceptions
Natural words are not stemmed mechanically. `Billing` must not be forced into `Bill*`. Route/config/CLI/package identifiers and the namespace root may use the repository identifier where appropriate.

## Guardability
Semantic with partial hard enforcement through a component vocabulary profile.
