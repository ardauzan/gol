// test/gol_test.gleam

// External imports
import gleeunit
import gleeunit/should

// Public
// Setup
pub fn main() -> Nil {
  gleeunit.main()
}

// Test hello world
pub fn hello_world_test() -> Nil {
  1
  |> should.equal(1)
}
