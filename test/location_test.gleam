//// test/location_test.gleam
////
//// Module: location_test
////
//// Test module for location.
////
//// API:
//// - main() -> Nil
//// - compare_test() -> Nil
//// Internal:
//// * None

// Non-local imports:
import gleam/order as ord
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import location as loc

// Public:

/// Sets up the testing environment.
pub fn main() -> Nil {
  gle.main()
}

/// Tests the compare function.
pub fn compare_test() -> Nil {
  loc.Location(0, 0)
  |> loc.compare(loc.Location(0, 0))
  |> sho.equal(ord.Eq)

  loc.Location(2, 0)
  |> loc.compare(loc.Location(0, 1))
  |> sho.equal(ord.Lt)

  loc.Location(3, 0)
  |> loc.compare(loc.Location(4, 0))
  |> sho.equal(ord.Lt)

  loc.Location(5, 40)
  |> loc.compare(loc.Location(6, 7))
  |> sho.equal(ord.Gt)

  loc.Location(12, -4)
  |> loc.compare(loc.Location(8, -4))
  |> sho.equal(ord.Gt)
}
