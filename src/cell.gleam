//// src/cell.gleam
////
//// Module: cell
////
//// In this module, the Cell object and its functions are defined.
////
//// API:
//// - Cell: Alive(Location) | Dead(Location)
//// - is_alive(Cell) -> Bool
//// - compare(Cell, Cell) -> Order
//// - toggle(Cell) -> Cell
//// Internal:
//// * None

// Non-local imports:
import gleam/order.{type Order}

// Local imports:
import location.{type Location} as loc

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

/// Compares two Cells.
/// The result is based on the Location of the Cells.
pub fn compare(cell_1: Cell, cell_2: Cell) -> Order {
  loc.compare(cell_1.location, cell_2.location)
}

/// Toggles the state of the Cell, keeping the same Location.
pub fn toggle(cell: Cell) -> Cell {
  case cell {
    Alive(location) -> Dead(location)
    Dead(location) -> Alive(location)
  }
}
