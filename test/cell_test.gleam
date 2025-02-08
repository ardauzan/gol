//// test/cell_test.gleam
////
//// Module: cell_test
////
//// Test module for cell.
////
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - is_alive_test() -> Nil
//// - is_dead_test() -> Nil
//// - toggle_test() -> Nil
//// - get_location_test() -> Nil
//// Internal:
//// * None

// External imports:
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell as cel
import location as loc

// Public:

/// Setup for testing.
pub fn main() -> Nil {
  gle.main()
}

/// Test the cell constructor.
pub fn new_test() -> Nil {
  cel.new(loc.new(16, -14), False)
  |> sho.equal(cel.Dead(#(16, -14)))
  cel.new(loc.new(19, -4), True)
  |> sho.equal(cel.Alive(#(19, -4)))
}

/// Test the is_alive function.
pub fn is_alive_test() -> Nil {
  cel.is_alive(cel.new(loc.new(33, -14), True))
  |> sho.equal(True)
  cel.is_alive(cel.new(loc.new(47, 0), False))
  |> sho.equal(False)
}

/// Test the is_dead function.
pub fn is_dead_test() -> Nil {
  cel.is_dead(cel.new(loc.new(10, -10), False))
  |> sho.equal(True)
  cel.is_dead(cel.new(loc.new(11, 6), True))
  |> sho.equal(False)
}

/// Test the toggle function.
pub fn toggle_test() -> Nil {
  cel.toggle(cel.new(loc.new(10, -10), False))
  |> sho.equal(cel.Alive(#(10, -10)))
  cel.toggle(cel.new(loc.new(11, 6), True))
  |> sho.equal(cel.Dead(#(11, 6)))
}

/// Test the get_location function.
pub fn get_location_test() -> Nil {
  cel.get_location(cel.new(loc.new(8, 0), True))
  |> sho.equal(#(8, 0))
  cel.get_location(cel.new(loc.new(0, 0), False))
  |> sho.equal(#(0, 0))
}
