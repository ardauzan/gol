//// src/neighbourhood.gleam
////
//// Module: neighbourhood
////
//// In this module, the Neighbourhood type and its functions are defined.
////
//// API:
//// - Neighbourhood
//// - get_neighbourhood_from_grid(Grid, Location) -> Neighbourhood
//// - get_neighbourhood_from_state(GridState, Location) -> Neighbourhood
//// - get_center_state(Neighbourhood) -> Bool
//// - get_alive_neighbour_count(Neighbourhood) -> Int
//// Internal:
//// - count(Cell) -> Int

// Local imports:
import cell.{type Cell} as cel
import grid.{type Grid, type GridState} as gri
import location.{type Location}

// Public:

/// Neighbourhood type definition.
pub type Neighbourhood {
  Neighbourhood(
    top_left: Cell,
    top: Cell,
    top_right: Cell,
    left: Cell,
    center: Cell,
    right: Cell,
    bottom_left: Cell,
    bottom: Cell,
    bottom_right: Cell,
  )
}

/// Get the neighbourhood of a cell in the grid.
pub fn get_neighbourhood_from_grid(
  grid: Grid,
  location: Location,
) -> Neighbourhood {
  case gri.get_neighbours_from_grid(grid, location) {
    [top_left, top, top_right, left, right, bottom_left, bottom, bottom_right] ->
      Neighbourhood(
        top_left,
        top,
        top_right,
        left,
        gri.get_cell_from_grid(grid, location),
        right,
        bottom_left,
        bottom,
        bottom_right,
      )
    _ -> panic as "Impossible state"
  }
}

/// Get the center cell's state in the neighbourhood.
pub fn get_center_state(neighbourhood: Neighbourhood) -> Bool {
  cel.is_alive(neighbourhood.center)
}

/// Get the number of alive neighbours in the neighbourhood.
pub fn get_alive_neighbour_count(neighbourhood: Neighbourhood) -> Int {
  count(neighbourhood.top_left)
  + count(neighbourhood.top)
  + count(neighbourhood.top_right)
  + count(neighbourhood.left)
  + count(neighbourhood.right)
  + count(neighbourhood.bottom_left)
  + count(neighbourhood.bottom)
  + count(neighbourhood.bottom_right)
}

// Private:
fn count(cell: Cell) -> Int {
  case cell {
    cel.Alive(_) -> 1
    cel.Dead(_) -> 0
  }
}
