import Lake
open Lake DSL

package «x402-cosmos» where
  name := "x402-cosmos"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"

lean_lib «X402Cosmos» where
  roots := #[`X402Cosmos]
