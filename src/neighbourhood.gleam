//// src/neighbourhood.gleam
//// 
//// Module: neighbourhood
//// API:
//// - Neighbourhood
//// Internal:
//// * None

// Local imports
import cell as cel

// Public

/// Neighbourhood type definition:
/// A neighbourhood is a tuple of eight cells.
/// It represents the cells around a cel which effects its next state.
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
  )
