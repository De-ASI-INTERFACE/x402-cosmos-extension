-- x402-Cosmos Payment Verification Formal Model
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09

import Mathlib.Data.Finset.Basic

namespace X402Cosmos

structure IBCPacket where
  source_chain    : Nat
  dest_chain      : Nat
  sequence        : Nat
  timeout_ns      : Nat
  deriving Repr

structure CW20Payment where
  nonce      : String
  amount     : Nat
  expires_at : Nat
  deriving Repr

structure FacilitatorState where
  settled_packets : Finset (Nat × Nat × Nat)
  used_nonces     : Finset String
  block_time_ns   : Nat
  deriving Repr

def ibc_verify (p : IBCPacket) (s : FacilitatorState) : Prop :=
  (p.source_chain, p.dest_chain, p.sequence) ∉ s.settled_packets ∧
  s.block_time_ns < p.timeout_ns

def cw20_verify (p : CW20Payment) (s : FacilitatorState) : Prop :=
  p.nonce ∉ s.used_nonces ∧ s.block_time_ns ≤ p.expires_at

theorem ibc_packet_unique (p : IBCPacket) (s : FacilitatorState)
    (h : ibc_verify p s) :
    (p.source_chain, p.dest_chain, p.sequence) ∉ s.settled_packets := h.1

end X402Cosmos
