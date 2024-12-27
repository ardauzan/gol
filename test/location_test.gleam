//// test/location_test.gleam
//// 
//// Module: location_test
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - get_x_test() -> Nil
//// - get_y_test() -> Nil
//// Internal:
//// * None

// External imports
import gleeunit as gle
import gleeunit/should as sho

// Local imports
import location as loc

// Public

/// Setup for testing:
pub fn main() -> Nil {
  gle.main()
}

/// Test the location constructor.
pub fn new_test() -> Nil {
  loc.new(10, -10)
  |> sho.equal(#(10, -10))
  loc.new(0, 0)
  |> sho.equal(#(0, 0))
}

/// Test the get_x function.
pub fn get_x_test() -> Nil {
  loc.get_x(loc.new(23, -43))
  |> sho.equal(23)
  loc.get_x(loc.new(0, 0))
  |> sho.equal(0)
}

/// Test the get_y function.
pub fn get_y_test() -> Nil {
  loc.get_y(loc.new(11, 0))
  |> sho.equal(0)
  loc.get_y(loc.new(0, 1))
  |> sho.equal(1)
}
