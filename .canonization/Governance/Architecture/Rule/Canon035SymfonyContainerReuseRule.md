# Canon035SymfonyContainerReuseRule — Stable Symfony Compiled Container Across Requests

## Requirement
For unchanged source and configuration in one runtime environment, normal HTTP requests must reuse the stable Symfony compiled-container/cache identity rather than forcing container rebuild or cache invalidation on every request.

## Prohibited Runtime Patterns
Application runtime code must not invoke cache clear/warmup, force Kernel reboot, hardcode a dev/debug Kernel for normal runtime, or derive Kernel cache/container identity from request, time, random, or other per-request state.

Custom `getContainerClass()` or cache-directory behavior is permitted only when its identity remains stable for unchanged application inputs; unusual customization is review-worthy.

## Production Intent
Production runtime configuration must permit normal Symfony compiled-container reuse. Cache warming/clearing belongs to deployment and maintenance operations, not request handling.

## Validation Boundary
A two-request probe comparing container/cache artifacts is a useful validation operation, but it is not itself the Canon. The Canon is the stable-reuse invariant; Gating statically blocks known invalidators and unstable identity patterns.

## Guardability
Hard for deterministic request-time invalidators and request/time/random-derived cache identity; warning for custom container identity requiring semantic review.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "PHP/config candidates capable of rebuilding or varying Symfony container identity"
  extraction: [cache_clear_patterns, kernel_reboot_patterns, container_identity_overrides, cache_directory_overrides]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [custom_container_identity, custom_cache_directory, request_or_time_dependent_candidate]
  executable_evidence: ["Gating Canon035 findings", "optional two-request container/cache probe"]
```

## Rationale
Container compilation is application initialization work. Repeating it during ordinary unchanged requests converts framework boot work into request-path latency and is non-canonical.
