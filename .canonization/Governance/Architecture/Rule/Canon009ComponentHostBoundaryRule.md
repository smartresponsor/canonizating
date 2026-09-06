# Canon009ComponentHostBoundaryRule — Standalone Component Does Not Depend on Host Implementation Classes

## Identity

Canon: `Canon009`
Gating mirror: `Canon009ComponentHostBoundaryRule.php`

## Requirement
A standalone component repository must remain independently installable from Host implementation details. The component may declare a public interface or extension point; the Host may implement and wire it through Symfony DI, but the component must not compile against private Host classes.

## Prohibited
Do not import Host-only implementation classes, inherit from Host private bases, use Host filesystem presence as an integration contract, or move component business capability into Host merely to satisfy coupling.

## Rationale
Host owns orchestration and integration implementations. Components own business capability and public contracts.

## Good example
The component defines `CartOfferProviderInterface`; Host supplies its implementation through DI.

## Bad example
A component class extends `App\\DataFixtures\\AbstractFakerFixture` when that base belongs only to Host.

## Exceptions
The Host repository itself is not subject to the standalone side of this boundary. Shared implementation must become a declared package rather than an implicit exception.

## Guardability
Hard plus semantic profile configuration identifying Host-owned namespaces.
