//// test/grid_test.gleam
////
//// Module: grid_test
////
//// Test module for grid.
////
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - add_test() -> Nil
//// - get_test() -> Nil
//// - make_proper_test() -> Nil
//// - make_transient_test() -> Nil
//// - remove_at_location_test() -> Nil
//// - get_neighbours_test() -> Nil
//// Internal:
//// * None

// External imports:
import gleam/io
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell as cel
import grid as gri
import location as loc

// Public:

/// Setup for testing.
pub fn main() -> Nil {
  gle.main()
}

/// Test the grid constructor.
pub fn new_test() -> Nil {
  gri.new()
  |> sho.equal([])
}

/// Test the add function.
pub fn add_test() -> Nil {
  gri.new()
  |> gri.add(cel.new(loc.new(1, 1), True))
  |> gri.add(cel.new(loc.new(1, 1), True))
  |> gri.add(cel.new(loc.new(0, 0), False))
  |> sho.equal([cel.Dead(#(0, 0)), cel.Alive(#(1, 1))])
}

/// Test the get function.
pub fn get_test() -> Nil {
  gri.new()
  |> gri.add(cel.new(loc.new(1, 1), False))
  |> gri.get(loc.new(1, 1))
  |> sho.equal(cel.Dead(#(1, 1)))
}

/// Test the make_proper function.
pub fn make_proper_test() -> Nil {
  gri.new()
  |> gri.add(cel.new(loc.new(1, 1), False))
  |> gri.make_proper()
  |> sho.equal([])
}

/// Test the make_transient function.
pub fn make_transient_test() -> Nil {
  io.println("Todo")
}

/// Test the remove_at_location function.
pub fn remove_at_location_test() -> Nil {
  io.println("Todo")
}

/// Test the get_neighbours_test function.
pub fn get_neighbours_test() -> Nil {
  io.println("Todo")
}
