//// src/ruleset.gleam
//// 
//// Module: ruleset
//// API:
//// - Ruleset
//// Internal:
//// * None

// Local imports
import rule as rul

// Public

/// Ruleset type definition
/// A ruleset is used to determine the next state of a cell based on it's current state and it's neighbourhood after a tick with any number of rules the ruleset contains applied to it.
pub type Ruleset =
  List(rul.Rule)
