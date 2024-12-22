//// src/location_set.gleam
//// 
//// Module: location_set
//// API:
//// - LocationSet
//// Internal:
//// * None

// External imports
import gleam/set

// Local imports
import location as locati

// Public

/// LocationSet type definition
pub type LocationSet =
  set.Set(locati.Location)
