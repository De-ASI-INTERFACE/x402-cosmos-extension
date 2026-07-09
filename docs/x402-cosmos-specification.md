# x402-Cosmos Specification

**Author:** Richard Patterson (@De-ASI-INTERFACE) | **Version:** 1.0.0 | **Date:** 2026-07-09

---

## 1. Overview

The x402-Cosmos Extension binds HTTP 402 to Cosmos's IBC-connected multi-chain ecosystem. Payment proofs are constructed using ADR-036 off-chain message signing (a Cosmos standard for arbitrary message authentication), ICS-20 token transfers carry the payment value across IBC channels, and CosmWasm contracts on the destination chain verify signature and transfer receipt. Tendermint BFT provides deterministic instant finality: once a block is committed with 2/3+ pre-commits, it is final with no possibility of reorg.

## 2. Payment Flow (Native Chain)

```
1. Client → Server:  GET /resource
2. Server → Client:  402 + X-Payment-Requirements: {denom, amount, recipient_addr, nonce, chain_id, memo_hash}
3. Client:           Sign ADR-036 PaymentProof with Cosmos wallet (Keplr/Leap)
4. Client:           Submit bank.MsgSend or wasm.MsgExecuteContract with memo = resource_hash
5. Client → Server:  GET /resource + X-Payment-Proof: {sig, tx_hash, height}
6. Server:           Query tx inclusion via LCD/RPC; verify ADR-036 sig; serve resource
```

## 3. IBC Cross-Chain Payment Flow

```
1. Server specifies: chain_id + IBC channel + denom (e.g. ibc/USDC via Noble)
2. Client submits ICS-20 MsgTransfer with memo = x402:<resource_hash>:<nonce>
3. Server monitors IBC packet acknowledgement on destination chain
4. Ack received = payment settled; resource served
```

## 4. ADR-036 Signing Structure

```json
{
  "chain_id": "",
  "account_number": "0",
  "sequence": "0",
  "fee": {"gas": "0", "amount": []},
  "msgs": [{
    "type": "sign/MsgSignData",
    "value": {
      "signer": "<bech32_address>",
      "data": "<base64(x402-payment-proof-json)>"
    }
  }],
  "memo": ""
}
```

## 5. CosmWasm Verifier Interface

```rust
#[cw_serde]
pub enum ExecuteMsg {
    VerifyPayment {
        proof: PaymentProof,
        sig: Binary,
        tx_hash: String,
    },
}

#[cw_serde]
pub struct PaymentProof {
    pub payer: String,      // bech32
    pub payee: String,      // bech32
    pub denom: String,      // ibc/... or native
    pub amount: Uint128,
    pub nonce: String,
    pub deadline: u64,
    pub resource_hash: String,
}
```

## 6. Finality & Security

- **Tendermint BFT:** 2/3+ pre-commits = deterministic finality in one block (~6s); no reorgs ever
- **IBC reliability:** ICS-20 packet acknowledgement provides cryptographic proof of cross-chain settlement
- **Replay prevention:** nonce + deadline stored in CosmWasm contract state
- **Formal proof:** `cosmos_tendermint_bft_finality` theorem (formal-models/)
