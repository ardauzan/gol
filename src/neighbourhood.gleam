//// src/neighbourhood.gleam
////
//// Module: neighbourhood
////
//// In this module, the Neighbourhood object and its functions are defined.
//// A Neighbourhood is a 3x3 matrix of Cells.
//// It is used to derive the next state of the center Cell.
////
//// API:
//// - Neighbourhood: Neighbourhood(Cell, Cell, Cell, Cell, Cell, Cell, Cell, Cell, Cell)
//// - get_neighbourhood(Grid, Location) -> Neighbourhood
//// - get_center_state(Neighbourhood) -> Bool
//// - get_alive_neighbour_count(Neighbourhood) -> Int
//// Internal:
//// - count_cell(Cell) -> Int

// Local imports:
import cell.{type Cell} as cel
import grid.{type Grid} as gri
import location.{type Location}

// Public:

/// A Neighbourhood is a 3x3 matrix of Cells.
/// It is used to derive the next state of the center Cell.
pub type Neighbourhood {
  Neighbourhood(
    bottom_left: Cell,
    bottom_center: Cell,
    bottom_right: Cell,
    left: Cell,
    center: Cell,
    right: Cell,
    top_left: Cell,
    top_center: Cell,
    top_right: Cell,
  )
}

/// Gets the Neighbourhood of a Cell in the Grid.
/// We know the shape of the returned neighbours array so there is no need to account for different shapes.
pub fn get_neighbourhood(grid: Grid, location: Location) -> Neighbourhood {
  case gri.get_neighbours(grid, location) {
    [
      bottom_left,
      bottom_center,
      bottom_right,
      left,
      right,
      top_left,
      top_center,
      top_right,
    ] ->
      Neighbourhood(
        bottom_left,
        bottom_center,
        bottom_right,
        left,
        gri.get_cell(grid, location),
        right,
        top_left,
        top_center,
        top_right,
      )
    _ -> panic as "Impossible state"
  }
}

/// Gets the center Cell's state in the Neighbourhood.
pub fn get_center_state(neighbourhood: Neighbourhood) -> Bool {
  cel.is_alive(neighbourhood.center)
}

/// Gets the number of alive neighbours in the Neighbourhood.
pub fn get_alive_neighbour_count(neighbourhood: Neighbourhood) -> Int {
  count_cell(neighbourhood.bottom_left)
  + count_cell(neighbourhood.bottom_center)
  + count_cell(neighbourhood.bottom_right)
  + count_cell(neighbourhood.left)
  + count_cell(neighbourhood.right)
  + count_cell(neighbourhood.top_left)
  + count_cell(neighbourhood.top_center)
  + count_cell(neighbourhood.top_right)
}

// Private:

/// Counts a Cell.
fn count_cell(cell: Cell) -> Int {
  case cell {
    cel.Alive(_) -> 1
    cel.Dead(_) -> 0
  }
}
