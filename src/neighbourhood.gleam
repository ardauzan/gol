//// src/neighbourhood.gleam
////
//// Module: neighbourhood
////
//// In this module, the Neighbourhood type and its functions are defined.
////
//// API:
//// - Neighbourhood
//// - get(Grid, Location) -> Neighbourhood
//// Internal:
//// * None

// Local imports:
import cell as cel
import grid as gri
import location as loc

// Public:

/// Neighbourhood type definition.
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

/// Get the number of alive neighbours in a neighbourhood.
pub fn alive_neighbour_count(neighbourhood: Neighbourhood) -> Int {
  let #(cell1, cell2, cell3, cell4, _cell5, cell6, cell7, cell8, cell9) =
    neighbourhood
  count_cell(cell1)
  + count_cell(cell2)
  + count_cell(cell3)
  + count_cell(cell4)
  + count_cell(cell6)
  + count_cell(cell7)
  + count_cell(cell8)
  + count_cell(cell9)
}

// Private:

/// Count a cell.
fn count_cell(cell: cel.Cell) -> Int {
  case cel.is_alive(cell) {
    True -> 1
    False -> 0
  }
}
