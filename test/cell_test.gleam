//// test/cell_test.gleam
//// 
//// Module: cell_test
//// API:
//// * None
//// Internal:
//// * None

// External imports
import gleeunit as gle
import gleeunit/should as sho

// Local imports
import cell as cel
import location as loc

// Public

/// Setup for testing:
pub fn main() -> Nil {
  gle.main()
}

/// Test the cell constructor.
pub fn new_test() -> Nil {
  cel.new(loc.new(16, -14), False)
  |> sho.equal(cel.Dead(#(16, -14)))
}

/// Test the is_alive function.
pub fn is_alive_test() -> Nil {
  cel.new(loc.new(33, -14), True)
  |> cel.is_alive
  |> sho.equal(True)
}

/// Test the is_dead function.
pub fn is_dead_test() -> Nil {
  cel.new(loc.new(10, -10), False)
  |> cel.is_dead
  |> sho.equal(True)
}

/// Test the toggle function.
pub fn toggle_test() -> Nil {
  cel.new(loc.new(10, -10), True)
  |> cel.toggle
  |> cel.is_dead
  |> sho.equal(True)
}

/// Test the get_location function.
pub fn get_location_test() -> Nil {
  cel.new(loc.new(8, 0), True)
  |> cel.get_location
  |> sho.equal(#(8, 0))
}
