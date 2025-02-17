//// test/lib_test.gleam
////
//// Module: lib_test
////
//// Test module for lib.
////
//// API:
//// - main() -> Nil
//// - remove_test() -> Nil
//// Internal:
//// * None

// External imports:
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import lib

// Public:

/// Setup for testing.
pub fn main() -> Nil {
  gle.main()
}

/// Test the remove function.
pub fn remove_test() -> Nil {
  [1, 2, 3, 4, 5]
  |> lib.remove(3)
  |> sho.equal([1, 2, 4, 5])
  [11, 12, 13, 13, 14, 14, 15]
  |> lib.remove(13)
  |> sho.equal([11, 12, 14, 14, 15])
}
