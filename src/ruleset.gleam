//// src/ruleset.gleam
////
//// Module: ruleset
////
//// In this module, the Ruleset type and its functions are defined.
////
//// API:
//// - Ruleset
//// Internal:
//// * None

// Local imports:
import rule as rul

// Public:

/// Ruleset type definition.
/// A ruleset is used to determine the next state of a cell based on its current state and its neighbourhood after a tick with any number of rules the ruleset contains applied to it.
pub type Ruleset =
  List(rul.Rule)
