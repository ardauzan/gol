// External imports

// External imports
/// src/neighbourhood_set.gleam
/// 
/// Module: neighbourhood_set
/// API:
/// - NeighbourhoodSet
/// Internal:
/// * None
import gleam/set

// Local imports
import neighbourhood as neighb

// Public

/// NeighbourhoodSet type definition
pub type NeighbourhoodSet =
  set.Set(neighb.Neighbourhood)
