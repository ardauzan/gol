//// src/cell.gleam
////
//// Module: cell
////
//// In this module, the Cell type and its functions are defined.
//// A cell is either alive or dead and it has a location.
////
//// API:
//// - Cell
//// - toggle(Cell) -> Cell
//// - is_alive(Cell) -> Bool
//// Internal:
//// * None

// Local imports:
import location.{type Location}

// Public:

/// Cell type definition.
pub type Cell {
  Alive(location: Location)
  Dead(location: Location)
}

/// Toggle the state of the cell.
pub fn toggle(cell: Cell) -> Cell {
  case cell {
    Alive(location) -> Dead(location)
    Dead(location) -> Alive(location)
  }
}

/// Get if the cell is alive.
pub fn is_alive(cell: Cell) -> Bool {
  case cell {
    Alive(_) -> True
    Dead(_) -> False
  }
}
