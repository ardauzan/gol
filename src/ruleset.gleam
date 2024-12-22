//// src/ruleset.gleam
//// 
//// Module: ruleset
//// API:
//// - Ruleset
//// Internal:
//// * None

// External imports
import gleam/set as s

// Local imports
import rule as r

// Public

/// Ruleset type definition
pub type Ruleset =
  s.Set(r.Rule)
