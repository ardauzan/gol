//// test/cell_test.gleam
////
//// Module: cell_test
////
//// Tests for the cell module.
////
//// API:
//// - main() -> Nil
//// - is_alive_test() -> Nil
//// - compare_test() -> Nil
//// - toggle_test() -> Nil
//// Internal:
//// * None

// Non-local imports:
import gleam/order as ord
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

  cel.Dead(loc.Location(8, 2))
  |> cel.is_alive
  |> sho.be_false
}

/// Tests the compare function.
pub fn compare_test() -> Nil {
  cel.Alive(loc.Location(2, 1))
  |> cel.compare(cel.Alive(loc.Location(1, 1)))
  |> sho.equal(ord.Gt)

  cel.Dead(loc.Location(1, -8))
  |> cel.compare(cel.Dead(loc.Location(3, -9)))
  |> sho.equal(ord.Gt)

  cel.Alive(loc.Location(0, 0))
  |> cel.compare(cel.Dead(loc.Location(1, 1)))
  |> sho.equal(ord.Gt)

  cel.Alive(loc.Location(0, 0))
  |> cel.compare(cel.Alive(loc.Location(0, 0)))
  |> sho.equal(ord.Eq)

  cel.Dead(loc.Location(5, -4))
  |> cel.compare(cel.Dead(loc.Location(5, -4)))
  |> sho.equal(ord.Eq)

  cel.Alive(loc.Location(0, 0))
  |> cel.compare(cel.Alive(loc.Location(0, 2)))
  |> sho.equal(ord.Lt)

  cel.Dead(loc.Location(88, 2))
  |> cel.compare(cel.Dead(loc.Location(89, 2)))
  |> sho.equal(ord.Lt)

  cel.Dead(loc.Location(5, 5))
  |> cel.compare(cel.Alive(loc.Location(1, 1)))
  |> sho.equal(ord.Lt)
}

/// Tests the toggle function.
pub fn toggle_test() -> Nil {
  cel.Alive(loc.Location(0, 0))
  |> cel.toggle
  |> sho.equal(cel.Dead(loc.Location(0, 0)))

  cel.Dead(loc.Location(-1, 9))
  |> cel.toggle
  |> sho.equal(cel.Alive(loc.Location(-1, 9)))
}
