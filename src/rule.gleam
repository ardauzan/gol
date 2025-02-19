//// src/rule.gleam
////
//// Module: rule
////
//// In this module, the Rule type and its functions are defined.
//// A rule is a function that takes a Neighbourhood and returns a Cell.
//// The return can be either a valid Cell or None.
//// None means that the cell should not change state.
////
//// API:
//// - Rule
//// Internal:
//// * None

// External imports:
import gleam/option.{type Option}

// Local imports:
import cell.{type Cell}
import neighbourhood.{type Neighbourhood}

// Public:

/// Rule type alias.
pub type Rule =
  fn(Neighbourhood) -> Option(Cell)
