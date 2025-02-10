//// src/neighbourhood.gleam
////
//// Module: neighbourhood
////
//// In this module, the Neighbourhood type and its functions are defined.
//// A neighbourhood is a tuple of nine cells.
//// It represents the cell and the cells around a cell which effects its next state.
////
//// API:
//// - NeighbourhoodError
//// - Neighbourhood
//// - new(Grid, Location) -> Neighbourhood
//// - get_center_state(Neighbourhood) -> Bool
//// - get_alive_neighbour_count(Neighbourhood) -> Int
//// Internal:
//// - count_cell(Cell) -> Int

// Local imports:
import cell as cel
import grid as gri
import location as loc

// Public:

/// NeighbourhoodError type definition.
/// A neighbourhood error (specifically the sole one defined below) is thrown only if the result of the get_neighbours function has a shape other than [8], which would never happen.
/// It is defined in order not to return a default neighbourhood when pattern matching.
/// Directly destructuring the result of get_neighbours as a list of length 8 doesn't work for obvious reasons.
/// Returning a default neighbourhood would change no functionality but make the code more difficult to read.
pub type NeighbourhoodError {
  InvalidNeighboursGivenError
}

/// Neighbourhood type definition.
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

/// Get neighbourhood of a location on a grid.
pub fn new(
  grid: gri.Grid,
  location: loc.Location,
) -> Result(Neighbourhood, NeighbourhoodError) {
  case gri.get_neighbours(grid, location) {
    [cell1, cell2, cell3, cell4, cell6, cell7, cell8, cell9] ->
      Ok(#(
        cell1,
        cell2,
        cell3,
        cell4,
        gri.get(grid, location),
        cell6,
        cell7,
        cell8,
        cell9,
      ))
    _other -> Error(InvalidNeighboursGivenError)
    // Would never happen! We still need to handle it to satisfy Gleam's type system. (Exhaustive pattern matching.)
  }
}

/// Get the center state of a neighbourhood.
pub fn get_center_state(neighbourhood: Neighbourhood) -> Bool {
  let #(_cell1, _cell2, _cell3, _cell4, cell5, _cell6, _cell7, _cell8, _cell9) =
    neighbourhood
  cel.is_alive(cell5)
}

/// Get the number of alive neighbours in a neighbourhood.
pub fn get_alive_neighbour_count(neighbourhood: Neighbourhood) -> Int {
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
