//// src/cell.gleam
////
//// Module: cell
////
//// In this module, the Cell object and its functions are defined.
////
//// API:
//// - Cell: Alive(Location) | Dead(Location)
//// - is_alive(Cell) -> Bool
//// - toggle(Cell) -> Cell
//// Internal:
//// * None

// Local imports:
import location.{type Location}

// Public:

/// A Cell is either alive or dead.
/// It also has a Location associated with it.
pub type Cell {
  Alive(location: Location)
  Dead(location: Location)
}

/// Checks if the Cell is alive.
pub fn is_alive(cell: Cell) -> Bool {
  case cell {
    Alive(_) -> True
    Dead(_) -> False
  }
}

/// Toggles the state of the Cell, keeping the same Location.
pub fn toggle(cell: Cell) -> Cell {
  case cell {
    Alive(location) -> Dead(location)
    Dead(location) -> Alive(location)
  }
}
