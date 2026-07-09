-- x402-Cosmos Basic | Author: Richard Patterson (@De-ASI-INTERFACE)
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace X402Cosmos

structure PaymentAuth where
  sequence   : Nat  -- account sequence number
  amount     : Nat
  timeout_ts : Nat  -- IBC timeout timestamp
  deriving Repr, DecidableEq

structure AccountState where
  current_sequence : Nat
  block_time       : Nat
  deriving Repr

def verify (a : PaymentAuth) (s : AccountState) : Prop :=
  a.sequence = s.current_sequence ∧ s.block_time ≤ a.timeout_ts

theorem cosmos_seq_valid (a : PaymentAuth) (s : AccountState) (h : verify a s)
    : a.sequence = s.current_sequence := h.1

theorem cosmos_not_expired (a : PaymentAuth) (s : AccountState) (h : verify a s)
    : s.block_time ≤ a.timeout_ts := h.2

end X402Cosmos
