//// src/cell_set.gleam
//// 
//// Module: cell_set
//// API:
//// - CellSet
//// Internal:
//// * None

// External imports
import gleam/set

// Local imports
import cell

// Public

/// CellSet type definition
pub type CellSet =
  set.Set(cell.Cell)
