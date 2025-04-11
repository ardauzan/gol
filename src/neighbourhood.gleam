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
//// Internal:
//// * None

// Local imports:
import cell.{type Cell}
import grid.{type Grid} as gri
import location.{type Location}

// Public:

/// A Neighbourhood is a 3x3 matrix of Cells.
/// It is used to derive the next state of the center Cell after a Rule is applied to it (ticked).
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

/// Gets the Neighbourhood of a Cell in a Grid.
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
