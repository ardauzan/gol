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
  let x = 10
  let y = -10
  loc.new(x, y)
  |> sho.equal(#(10, -10))
}

/// Test the get_x function.
pub fn get_x_test() -> Nil {
  let x = 23
  let y = -43
  let location = loc.new(x, y)
  loc.get_x(location)
  |> sho.equal(23)
}

/// Test the get_y function.
pub fn get_y_test() -> Nil {
  let x = 11
  let y = 0
  let location = loc.new(x, y)
  loc.get_y(location)
  |> sho.equal(0)
}
