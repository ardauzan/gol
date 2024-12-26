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
import grid as gri

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

/// Test the make_proper function.
pub fn make_proper_test() -> Nil {
  todo
}

/// Test the make_transient function.
pub fn make_transient_test() -> Nil {
  todo
}

/// Test the add function.
pub fn add_test() -> Nil {
  todo
}

/// Test the get function.
pub fn get_test() -> Nil {
  todo
}

/// Test the remove_at_location function.
pub fn remove_at_location_test() -> Nil {
  todo
}

/// Test the get_neighbours_test function.
pub fn get_neighbours_test() -> Nil {
  todo
}
