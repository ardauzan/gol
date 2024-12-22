//// src/cell.gleam
//// 
//// Module: cell
//// API:
//// - Cell
//// Internal:
//// * None

// Local imports
import location as locati

// Public

/// Cell type definition
pub type Cell {
  Alive(locati.Location)
  Dead(locati.Location)
}
