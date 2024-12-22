//// test/gol_test.gleam
//// 
//// Module: gol_test
//// API:
//// - main() -> Nil
//// - hello_world_test() -> Nil
//// Internal:
//// * None

// External imports
import gleeunit as glet
import gleeunit/should as shld

// Public

/// Setup for testing
pub fn main() -> Nil {
  glet.main()
}

/// Test hello world
pub fn hello_world_test() -> Nil {
  1
  |> shld.equal(1)
}
