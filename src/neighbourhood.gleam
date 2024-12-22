//// src/neighbourhood.gleam
//// 
//// Module: neighbourhood
//// API:
//// - Neighbourhood
//// Internal:
//// * None

// Local imports
import cell

// Public

/// Neighbourhood type definition
pub type Neighbourhood =
  #(
    cell.Cell,
    cell.Cell,
    cell.Cell,
    cell.Cell,
    cell.Cell,
    cell.Cell,
    cell.Cell,
    cell.Cell,
  )
