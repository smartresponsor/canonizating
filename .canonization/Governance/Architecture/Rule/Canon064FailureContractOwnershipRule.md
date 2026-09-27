# Canon064FailureContractOwnershipRule — Generic Failure Mechanism, Consumer Vocabulary

## Identity

Canon: Canon064
Gating mirror: Canon064FailureContractOwnershipRule.php

## Requirement

The platform failure-contract mechanism is consumer-agnostic.

Failing owns the grammar and runtime mechanism for failure declarations, registration, resolution, RFC 9457 projection, and operation failure inventory.

Consumer repositories own concrete business failure vocabulary, titles, problem types, exception mappings, and operation membership.

Dependency direction is one-way:

    consumer -> failing/failure
    failing/failure -X-> consumer

Failing must not import, enumerate, branch on, or otherwise encode named consumer/domain concepts.

## Canonical split

Central mechanism may define:

- FailureCode grammar;
- FailureType representation;
- FailureDefinitionDTO shape;
- provider contracts;
- registry and resolver mechanics;
- operation failure inventory mechanics;
- thin Symfony integration;
- RFC 9457 projection.

Consumers define:

- concrete failure codes;
- concrete public titles/types;
- business exception mappings;
- which failures belong to which operations.

## Guardability

Hard for direct source-code consumer/domain leakage into Failing. Semantic review remains necessary for disguised business vocabulary.

## Evidence Contract

evidence_contract:
  coverage: "Failing source dependency and vocabulary boundary"
  extraction: [composer_identity, php_imports, source_tokens, provider_contracts]
  body_read: targeted
  reasoning: consumer vocabulary ownership
  escalation: [central_consumer_import, central_business_enumeration, reversed_dependency]
  executable_evidence: ["Gating Canon064 findings"]
