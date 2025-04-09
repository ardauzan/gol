//// src/rule.gleam
////
//// Module: rule
////
//// In this module, Rule object is defined.
//// A Rule is a function that takes a Neighbourhood and returns a Cell.
//// The return can be either a valid Cell or None.
//// None means that the cell should not change state.
//// If the return is a Cell, that Cell will replace the current Cell in the next state.
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

/// A Rule is a function that takes a Neighbourhood and returns a Cell.
/// The return can be either a valid Cell or None.
/// None means that the cell should not change state.
/// If the return is a Cell, that Cell will replace the current Cell in the next state.
pub type Rule =
  fn(Neighbourhood) -> Option(Cell)
