//// src/cell.gleam
////
//// Module: cell
////
//// In this module, the Cell type and its functions are defined.
//// A cell is either alive or dead and it has a location.
////
//// API:
//// - Cell
//// - new(Location, Bool) -> Cell
//// - is_alive(Cell) -> Bool
//// - is_dead(Cell) -> Bool
//// - get_location(Cell) -> Location
//// - toggle(Cell) -> Cell
//// Internal:
//// * None

// Local imports:
import location as loc

// Public:

/// Cell type definition.
pub type Cell {
  Alive(location: loc.Location)
  Dead(location: loc.Location)
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

/// Get the location of the cell.
pub fn get_location(cell: Cell) -> loc.Location {
  case cell {
    Alive(location) -> location
    Dead(location) -> location
  }
}

/// Toggle the state of the cell.
pub fn toggle(cell: Cell) -> Cell {
  case cell {
    Alive(location) -> Dead(location)
    Dead(location) -> Alive(location)
  }
}
