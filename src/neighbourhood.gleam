//// src/neighbourhood.gleam
////
//// Module: neighbourhood
////
//// In this module, the Neighbourhood type and its functions are defined.
////
//// API:
//// - Neighbourhood
//// - get_neighbourhood(GridState, Location) -> Neighbourhood
//// - get_center_state(Neighbourhood) -> Bool
//// - get_alive_neighbour_count(Neighbourhood) -> Int
//// Internal:
//// * None

// Local imports:
import cell.{type Cell}
import grid.{type GridState} as gri
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
pub fn get_neighbourhood(state: GridState, location: Location) -> Neighbourhood {
  case gri.get_neighbours_from_state(state, location) {
    [top_left, top, top_right, left, right, bottom_left, bottom, bottom_right] ->
      Neighbourhood(
        top_left,
        top,
        top_right,
        left,
        gri.get_cell_from_state(state, location),
        right,
        bottom_left,
        bottom,
        bottom_right,
      )
    _ -> panic as "Impossible state"
  }
}
