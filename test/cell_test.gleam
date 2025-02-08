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
//// - get_location_test() -> Nil
//// - toggle_test() -> Nil
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
  loc.new(16, -14)
  |> cel.new(False)
  |> sho.equal(cel.Dead(#(16, -14)))
}

/// Test the is_alive function.
pub fn is_alive_test() -> Nil {
  loc.new(33, -14)
  |> cel.new(True)
  |> cel.is_alive()
  |> sho.equal(True)
}

/// Test the is_dead function.
pub fn is_dead_test() -> Nil {
  loc.new(10, -10)
  |> cel.new(False)
  |> cel.is_dead()
  |> sho.equal(True)
}

/// Test the get_location function.
pub fn get_location_test() -> Nil {
  loc.new(8, 0)
  |> cel.new(True)
  |> cel.get_location()
  |> sho.equal(#(8, 0))
}

/// Test the toggle function.
pub fn toggle_test() -> Nil {
  loc.new(10, -10)
  |> cel.new(False)
  |> cel.toggle()
  |> sho.equal(cel.Alive(#(10, -10)))
}
