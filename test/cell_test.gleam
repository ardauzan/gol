//// test/cell_test.gleam
////
//// Module: cell_test
////
//// Test module for cell.
////
//// API:
//// - main() -> Nil
//// - is_alive_test() -> Nil
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

/// Test the is_alive function.
pub fn is_alive_test() -> Nil {
  cel.Alive(loc.Location(0, 0))
  |> cel.is_alive()
  |> sho.be_true()
  cel.Dead(loc.Location(0, 0))
  |> cel.is_alive()
  |> sho.be_false()
}

/// Test the toggle function.
pub fn toggle_test() -> Nil {
  cel.Alive(loc.Location(0, 0))
  |> cel.toggle()
  |> sho.equal(cel.Dead(loc.Location(0, 0)))
  cel.Dead(loc.Location(0, 0))
  |> cel.toggle()
  |> sho.equal(cel.Alive(loc.Location(0, 0)))
}
