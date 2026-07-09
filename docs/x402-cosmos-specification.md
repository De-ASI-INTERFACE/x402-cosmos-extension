# x402-Cosmos: HTTP 402 Payment-Gated Routing Specification

**Author:** Richard Patterson (@De-ASI-INTERFACE)
**Version:** 1.0.0 | **Date:** 2026-07-09
**Reference ID:** RP-DEASI-COS-2026-0709-001

## 1. IBC Payment Schema (`scheme: cosmos-ibc`)

```json
{
  "scheme": "cosmos-ibc",
  "sourceChain": "cosmoshub-4",
  "destChain": "osmosis-1",
  "ibcDenom": "ibc/27394FB092D2ECCD56123C74F36E4C1F926001CEADA9CA97EA622B25F41E5EB2",
  "amount": "1000000",
  "sender": "cosmos1<bech32>",
  "receiver": "osmo1<bech32-facilitator>",
  "timeoutTimestamp": "<unix-ns>",
  "packetSequence": "<uint64>",
  "signature": "<adr036-sig>"
}
```

## 2. CW-20 Payment Schema (`scheme: cosmos-cw20`)

```json
{
  "scheme": "cosmos-cw20",
  "chainId": "osmosis-1",
  "contractAddr": "osmo1<cw20-contract>",
  "amount": "<uint128>",
  "recipient": "osmo1<facilitator>",
  "nonce": "<string-uuid>",
  "expiresAt": "<unix-timestamp>",
  "signature": "<adr036-sig>"
}
```

## 3. Cosmos-Specific Invariants

1. **IBC Packet Uniqueness:** `(sourceChain, destChain, packetSequence)` triple is globally unique
2. **Timeout Enforcement:** `block_time_ns < timeoutTimestamp` before routing
3. **CW-20 Nonce Replay:** CosmWasm state map `used_nonces: Map<String, bool>` checked before execute
4. **Osmosis Route Verification:** Swap route validated against current pool state before payment settlement
5. **ADR-036 Signature:** Cosmos secp256k1 signature over canonical JSON payload

## 4. Attribution
Originated and authored by Richard Patterson (@De-ASI-INTERFACE), 2026-07-09.
