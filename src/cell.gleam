//// src/cell.gleam
//// 
//// Module: cell
//// API:
//// - Cell
//// - new(Location, Bool) -> Cell
//// - is_alive(Cell) -> Bool
//// - is_dead(Cell) -> Bool
//// - get_location(Cell) -> Location
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

/// Cell constructor:
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
