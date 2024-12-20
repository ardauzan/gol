// test/gol_test.gleam

// External imports
import gleeunit as glet
import gleeunit/should as shld

// Public
// Setup
pub fn main() -> Nil {
  glet.main()
}

// Test hello world
pub fn hello_world_test() -> Nil {
  1
  |> shld.equal(1)
}
