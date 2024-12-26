//// src/rule.gleam
//// 
//// Module: rule
//// API:
//// - Rule
//// Internal:
//// * None

// Local imports
import cell as cel
import neighbourhood as nei

// Public

/// Rule type definition
/// A rule is a function that takes a cell with it's neighbourhood and returns the next state of the cell after a tick.
pub type Rule =
  fn(nei.Neighbourhood) -> cel.Cell
