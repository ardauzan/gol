//// src/location.gleam
//// 
//// Module: location
//// API:
//// - Location
//// - new(Int, Int) -> Location
//// Internal:
//// * None

// Public

/// Location type definition:
/// Loction is two-dimensional, with x and y coordinates.
pub type Location =
  #(Int, Int)

/// Location constructor
pub fn new(x: Int, y: Int) -> Location {
  #(x, y)
}
