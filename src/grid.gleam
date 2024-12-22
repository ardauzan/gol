//// src/grid.gleam
//// 
//// Module: grid
//// API:
//// - Grid
//// Internal:
//// * None

// Local imports
import cell as cel

// Public

/// Grid type definition:
/// A grid is a list of cells.
/// It represents an infinite 2D array of cells.
/// It has two forms:
/// - Proper : It only contains unique alive cells.
/// - Transient : It contains unique alive and dead cells.
pub type Grid =
  List(cel.Cell)
