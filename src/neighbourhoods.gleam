//// src/neighbourhoods.gleam
////
//// Module: neighbourhoods
////
//// In this module, the Neighbourhoods type and its functions are defined.
////
//// API:
//// - Neighbourhoods
//// - get(Grid) -> Neighbourhoods
//// Internal:
//// - get_inner(Grid, Grid, Neighbourhoods) -> Neighbourhoods

// Local imports:
import cell as cel
import grid as gri
import neighbourhood as nei

// Public:

/// Neighbourhoods type definition.
/// Neighbourhoods type is represented by a list of neighbourhoods.
/// It serves usefull to separate it from the singular neighbourhood as their purpose for existence is different, that is why this is here, in a different source file.
pub type Neighbourhoods =
  List(nei.Neighbourhood)

/// Get the neighbourhoods of a grid.
pub fn get(grid: gri.Grid) -> Neighbourhoods {
  get_inner(gri.make_proper(grid), gri.make_transient(grid), [])
}

// Private:

/// Inner loop for getting the neighbourhoods.
fn get_inner(
  grid: gri.Grid,
  temp1: gri.Grid,
  temp2: Neighbourhoods,
) -> Neighbourhoods {
  case temp1 {
    [] -> temp2
    [head, ..tail] ->
      get_inner(grid, tail, [nei.get(grid, cel.get_location(head)), ..temp2])
  }
}
