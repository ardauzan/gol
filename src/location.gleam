//// src/location.gleam
////
//// Module: location
////
//// In this module, the Location type and its functions are defined.
//// A location is x and y coordinates.
////
//// API:
//// - Location
//// Internal:
//// * None

// Public:

/// Location type definition.
pub type Location {
  Location(x: Int, y: Int)
}
