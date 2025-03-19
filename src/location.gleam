//// src/location.gleam
////
//// Module: location
////
//// In this module, the Location object and its functions are defined.
////
//// API:
//// - Location: Location(Int, Int)
//// - compare(Location, Location) -> Order
//// Internal:
//// * None

// Non-local imports:
import gleam/order.{type Order} as ord

// Public:

/// Location type definition.
pub type Location {
  Location(x: Int, y: Int)
}

/// Compares two locations.
/// It is from top to bottom, left to right.
pub fn compare(location_1: Location, location_2: Location) -> Order {
  todo
}
