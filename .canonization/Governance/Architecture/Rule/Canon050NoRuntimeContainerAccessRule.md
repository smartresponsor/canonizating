# Canon050NoRuntimeContainerAccessRule — Runtime Code Does Not Access Container

## Identity

Canon: `Canon050`
Gating mirror: `Canon050NoRuntimeContainerAccessRule.php`

## Requirement

Runtime application code uses constructor/service injection and must not use the Symfony/Psr container as an application dependency.

## Prohibited

Direct ContainerInterface or ServiceLocator dependencies are prohibited outside framework/bootstrap integration.

## Rationale

Container access hides dependencies and bypasses Symfony's explicit service graph.

## Exceptions

`src/DependencyInjection/`, `src/Kernel.php` and the component Bundle class may integrate with the container as framework bootstrap surfaces.

## Guardability

Hard.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "first-party PHP runtime source"
  extraction: [relative_path, container_type]
  body_read: candidates_only
  reasoning: none
  escalation: []
  executable_evidence: ["Gating Canon050 findings"]
```
