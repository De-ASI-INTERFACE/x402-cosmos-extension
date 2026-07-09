-- x402-Cosmos Payment Verification | Author: Richard Patterson
import X402Cosmos.Basic

namespace X402Cosmos.Verification

def settle (a : PaymentAuth) (s : AccountState) (h : verify a s) : AccountState :=
  { s with current_sequence := s.current_sequence + 1 }

theorem settled_sequence_incremented (a : PaymentAuth) (s : AccountState) (h : verify a s)
    : (settle a s h).current_sequence = s.current_sequence + 1 := by
  simp [settle]

end X402Cosmos.Verification
