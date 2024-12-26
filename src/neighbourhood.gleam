//// src/neighbourhood.gleam
//// 
//// Module: neighbourhood
//// API:
//// - Neighbourhood
//// - get(Grid, Location) -> Neighbourhood
//// Internal:
//// * None

// Local imports
import cell as cel
import grid as gri
import location as loc

// Public

/// Neighbourhood type definition:
/// A neighbourhood is a tuple of eight cells.
/// It represents the cell and the cells around a cell which effects its next state.
pub type Neighbourhood =
  #(
    cel.Cell,
    cel.Cell,
    cel.Cell,
    cel.Cell,
    cel.Cell,
    cel.Cell,
    cel.Cell,
    cel.Cell,
    cel.Cell,
  )

/// Get neighbourhood of a location.
pub fn get(grid: gri.Grid, location: loc.Location) -> Neighbourhood {
  case gri.get_neighbours(grid, location) {
    [cell1, cell2, cell3, cell4, cell6, cell7, cell8, cell9] -> #(
      cell1,
      cell2,
      cell3,
      cell4,
      gri.get(grid, location),
      cell6,
      cell7,
      cell8,
      cell9,
    )
    _other -> #(
      cel.new(loc.new(-1, -1), False),
      cel.new(loc.new(-1, 0), False),
      cel.new(loc.new(-1, 1), False),
      cel.new(loc.new(0, -1), False),
      cel.new(loc.new(0, 0), False),
      cel.new(loc.new(0, 1), False),
      cel.new(loc.new(1, -1), False),
      cel.new(loc.new(1, 0), False),
      cel.new(loc.new(1, 1), False),
    )
  }
}
