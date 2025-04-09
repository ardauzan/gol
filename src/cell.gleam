//// src/cell.gleam
////
//// Module: cell
////
//// In this module, the Cell object and its functions are defined.
//// A Cell is either alive or dead.
//// It also has a Location associated with it.
////
//// API:
//// - Cell: Alive(Location) | Dead(Location)
//// - is_alive(Cell) -> Bool
//// - compare(Cell, Cell) -> Order
//// - toggle(Cell) -> Cell
//// Internal:
//// * None

// Non-local imports:
import gleam/order.{type Order} as ord

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
/// The result is based on the Cell's state primarily and then its Location.
/// Alive is greater than dead, if the state is the same, the Location is compared.
pub fn compare(cell_1: Cell, cell_2: Cell) -> Order {
  case cell_1, cell_2 {
    Alive(location_1), Alive(location_2) -> loc.compare(location_1, location_2)
    Dead(location_1), Dead(location_2) -> loc.compare(location_1, location_2)
    Alive(_), Dead(_) -> ord.Gt
    Dead(_), Alive(_) -> ord.Lt
  }
}

/// Toggles the state of the Cell, keeping the same Location.
pub fn toggle(cell: Cell) -> Cell {
  case cell {
    Alive(location) -> Dead(location)
    Dead(location) -> Alive(location)
  }
}
