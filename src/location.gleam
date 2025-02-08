//// src/location.gleam
////
//// Module: location
////
//// In this module, the Location type and its functions are defined.
//// Location is two-dimensional, with x and y coordinates.
//// It is the most basic unit of space in the game of life.
////
//// API:
//// - Location
//// - new(Int, Int) -> Location
//// - get_x(Location) -> Int
//// - get_y(Location) -> Int
//// Internal:
//// * None

// Public:

/// Location type definition.
pub type Location =
  #(Int, Int)

/// Location constructor.
pub fn new(x: Int, y: Int) -> Location {
  #(x, y)
}

/// Get the x coordinate of a location.
pub fn get_x(location: Location) -> Int {
  let #(x, _y) = location
  x
}

/// Get the y coordinate of a location.
pub fn get_y(location: Location) -> Int {
  let #(_x, y) = location
  y
}
