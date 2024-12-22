//// src/rule.gleam
//// 
//// Module: rule
//// API:
//// - Rule
//// Internal:
//// * None

// Local imports
import cell

// Public

/// Rule type definition
pub type Rule =
  fn(cell.Cell, Int) -> cell.Cell
