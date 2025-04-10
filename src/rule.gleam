//// src/rule.gleam
////
//// Module: rule
////
//// In this module, Rule object is defined.
//// A Rule is a function that takes a Neighbourhood and returns a Option(Cell).
//// The return can be either a valid Some(Cell) or None.
//// None means the Rule does not match the given Neighbourhood and the center Cell should not change state after a tick.
//// If the return is a Some(Cell), that means the Rule matches and that center Cell will replace the current center Cell after a tick.
//// The Rule can return a Some(Cell) that is equal to the current center Cell, in this case the Rule is still considered to be matched even though it does not actually change the state.
////
//// API:
//// - Rule: fn(Neighbourhood) -> Option(Cell)
//// Internal:
//// * None

// Non-local imports:
import gleam/option.{type Option}

// Local imports:
import cell.{type Cell}
import neighbourhood.{type Neighbourhood}

// Public:

/// A Rule is a function that takes a Neighbourhood and returns a Option(Cell).
/// The return can be either a valid Some(Cell) or None.
/// None means the Rule does not match the given Neighbourhood and the center Cell should not change state after a tick.
/// If the return is a Some(Cell), that means the Rule matches and that center Cell will replace the current center Cell after a tick.
/// The Rule can return a Some(Cell) that is equal to the current center Cell, in this case the Rule is still considered to be matched even though it does not actually change the state.
pub type Rule =
  fn(Neighbourhood) -> Option(Cell)
