//// src/cell.gleam
////
//// Module: cell
////
//// In this module, the Cell type and its functions are defined.
////
//// API:
//// - Cell
//// - new(Location, Bool) -> Cell
//// - is_alive(Cell) -> Bool
//// - is_dead(Cell) -> Bool
//// - toggle(Cell) -> Cell
//// - get_location(Cell) -> Location
//// Internal:
//// * None

// Local imports:
import location as loc

// Public:

/// Cell type definition.
/// A cell is either alive or dead.
/// It also has a location.
pub type Cell {
  Alive(loc.Location)
  Dead(loc.Location)
}

/// Cell constructor.
pub fn new(location: loc.Location, alive: Bool) -> Cell {
  case alive {
    True -> Alive(location)
    False -> Dead(location)
  }
}

/// Get if the cell is alive.
pub fn is_alive(cell: Cell) -> Bool {
  case cell {
    Alive(_location) -> True
    Dead(_location) -> False
  }
}

/// Get if the cell is dead.
pub fn is_dead(cell: Cell) -> Bool {
  !is_alive(cell)
}

/// Toggle the state of the cell.
pub fn toggle(cell: Cell) -> Cell {
  case cell {
    Alive(location) -> Dead(location)
    Dead(location) -> Alive(location)
  }
}

/// Get the location of the cell.
pub fn get_location(cell: Cell) -> loc.Location {
  case cell {
    Alive(location) -> location
    Dead(location) -> location
  }
}
