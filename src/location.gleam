//// src/location.gleam
////
//// Module: location
////
//// In this module, the Location object and its functions are defined.
//// Locations are comparable, two-dimensional points.
//// The first coordinate is the x coordinate and the second coordinate is the y coordinate.
////
//// API:
//// - Location: Location(Int, Int)
//// - compare(Location, Location) -> Order
//// Internal:
//// * None

// Non-local imports:
import gleam/order.{type Order} as ord

// Public:

/// Locations are comparable, two-dimensional points.
/// The first coordinate is the x coordinate and the second coordinate is the y coordinate.
pub type Location {
  Location(x: Int, y: Int)
}

/// Compares two locations.
/// The result is based on the Locations's y coordinate primarily and then its x coordinate.
/// Y coordinates are compared first and if they are equal, the x coordinates are compared.
pub fn compare(location_1: Location, location_2: Location) -> Order {
  case location_1.x, location_1.y, location_2.x, location_2.y {
    x_1, y_1, x_2, y_2 if y_1 > y_2 || y_1 == y_2 && x_1 > x_2 -> ord.Gt
    x_1, y_1, x_2, y_2 if y_1 < y_2 || y_1 == y_2 && x_1 < x_2 -> ord.Lt
    _, _, _, _ -> ord.Eq
  }
}
