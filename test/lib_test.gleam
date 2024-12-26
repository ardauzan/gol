//// test/lib_test.gleam
//// 
//// Module: lib_test
//// API:
//// * None
//// Internal:
//// * None

// External imports
import gleeunit as gle
import gleeunit/should as sho

// Local imports
import lib

// Public

/// Setup for testing:
pub fn main() -> Nil {
  gle.main()
}

/// Test the add_unique function.
pub fn add_unique_test() -> Nil {
  lib.add_unique([1, 2, 3], 4)
  |> sho.equal([4, 1, 2, 3])
  lib.add_unique([1, 2, 3], 1)
  |> sho.equal([1, 2, 3])
}

/// Test the remove function.
pub fn remove_test() -> Nil {
  lib.remove([1, 2, 3], 2)
  |> sho.equal([1, 3])
  lib.remove([1, 2, 3], 4)
  |> sho.equal([1, 2, 3])
}
