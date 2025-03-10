//// test/cell_test.gleam
////
//// Module: cell_test
////
//// Tests for the cell module.
////
//// API:
//// - main() -> Nil
//// - is_alive_test() -> Nil
//// - toggle_test() -> Nil
//// Internal:
//// * None

// Non-local imports:
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell as cel
import location as loc

// Public:

/// Sets up the testing environment.
pub fn main() -> Nil {
  gle.main()
}

/// Tests the is_alive function.
pub fn is_alive_test() -> Nil {
  cel.Alive(loc.Location(5, 5))
  |> cel.is_alive
  |> sho.be_true
  cel.Dead(loc.Location(8, 8))
  |> cel.is_alive
  |> sho.be_false
}

/// Tests the toggle function.
pub fn toggle_test() -> Nil {
  cel.Alive(loc.Location(0, 0))
  |> cel.toggle
  |> sho.equal(cel.Dead(loc.Location(0, 0)))
  cel.Dead(loc.Location(1, 1))
  |> cel.toggle
  |> sho.equal(cel.Alive(loc.Location(1, 1)))
}
