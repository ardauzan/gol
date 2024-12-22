//// src/location.gleam
//// 
//// Module: location
//// API:
//// - Location
//// - new(Int, Int) -> Location
//// - get_x(Location) -> Int
//// - get_y(Location) -> Int
//// Internal:
//// * None

// Public

/// Location type definition:
/// Loction is two-dimensional, with x and y coordinates.
pub type Location =
  #(Int, Int)

/// Location constructor:
/// A location is a point on a 2D plane of integer coordinates.
pub fn new(x: Int, y: Int) -> Location {
  #(x, y)
}

/// Get the x coordinate.
pub fn get_x(location: Location) -> Int {
  let #(x, _y) = location
  x
}

/// Get the y coordinate.
pub fn get_y(location: Location) -> Int {
  let #(_x, y) = location
  y
}
