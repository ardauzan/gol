//// src/cell.gleam
//// 
//// Module: cell
//// API:
//// - Cell
//// Internal:
//// * None

// Local imports
import location as loc

// Public

/// Cell type definition:
/// A cell is either alive or dead.
/// It also has a location.
pub type Cell {
  Alive(loc.Location)
  Dead(loc.Location)
}
