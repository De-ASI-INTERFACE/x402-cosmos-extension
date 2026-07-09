-- ============================================================
-- x402-Cosmos: Basic Re-export Shim
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Cosmos Hub / IBC / Osmosis
--
-- Re-exports X402Cosmos.PaymentVerification as the single
-- authoritative source of all shared types and definitions.
-- Chain-prefixed theorem aliases are provided for ergonomic use.
--
-- Note: Cosmos uses a monotone account sequence counter for
-- replay protection (not a Finset), so replay_prevented returns
-- an equality: a.sequence = s.current_sequence.
-- ============================================================
import X402Cosmos.PaymentVerification

namespace X402Cosmos

/-- Alias: sequence freshness under the Cosmos chain prefix.
    Cosmos replay protection is enforced by account sequence
    equality: a.sequence = s.current_sequence. -/
theorem cosmos_replay_prevented
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.sequence = s.current_sequence :=
  replay_prevented a s h

/-- Alias: IBC timeout enforcement under the Cosmos chain prefix.
    Delegates to within_expiry: s.block_time ≤ a.timeout_ts. -/
theorem cosmos_not_expired
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.block_time ≤ a.timeout_ts :=
  within_expiry a s h

end X402Cosmos
