# Release Notes — v1.0.0

**Title:** x402-Cosmos: HTTP 402 Payment-Gated Routing on Cosmos
**Version:** 1.0.0 | **Date:** 2026-07-09 | **Author:** Richard Patterson (@De-ASI-INTERFACE)

## Summary
First stable release. Canonical x402 payment-gated routing specification for Cosmos IBC ecosystem, using CosmWasm verifiers, ADR-036 signing, ICS-20 token transfers, and Tendermint instant finality.

## Contents

| File | Description |
|---|---|
| `docs/x402-cosmos-specification.md` | Full technical specification |
| `docs/prior-art-and-attribution.md` | Prior art record |
| `docs/x402-cosmos-council-charter.md` | Stewardship council charter |
| `docs/reference-implementations.md` | Implementation links |
| `docs/formal-models/CosmosPaymentVerifier.lean` | Lean 4 Tendermint BFT finality theorem |
| `CITATION.cff` | Academic citation metadata |
| `lakefile.lean` + `lean-toolchain` | Lean 4 v4.14.0 + Mathlib4 |
| `.github/workflows/lean-build.yml` | CI theorem verification |

## Attribution
All artifacts originated and authored by Richard Patterson (@De-ASI-INTERFACE).
