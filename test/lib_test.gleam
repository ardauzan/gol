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
  Nil
}

/// Test the remove function.
pub fn remove_test() -> Nil {
  [1, 2, 3]
  |> lib.remove(2)
  |> sho.equal([1, 3])
  Nil
}
