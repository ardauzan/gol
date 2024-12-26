//// test/location_test.gleam
//// 
//// Module: location_test
//// API:
//// * None
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
}

/// Test the get_x function.
pub fn get_x_test() -> Nil {
  loc.new(23, -43)
  |> loc.get_x
  |> sho.equal(23)
}

/// Test the get_y function.
pub fn get_y_test() -> Nil {
  loc.new(11, 0)
  |> loc.get_y
  |> sho.equal(0)
}
