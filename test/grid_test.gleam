//// test/grid_test.gleam
//// 
//// Module: grid_test
//// API:
//// * None
//// Internal:
//// * None

// External imports
import gleeunit as gle
import gleeunit/should as sho

// Local imports
import cell as cel
import grid as gri
import location as loc

// Public

/// Setup for testing:
pub fn main() -> Nil {
  gle.main()
}

/// Test the grid constructor.
pub fn new_test() -> Nil {
  gri.new()
  |> sho.equal([])
}
