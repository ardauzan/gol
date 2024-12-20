import gleeunit
import gleeunit/should

import grid

pub fn main() {
  gleeunit.main()
}

pub fn hello_world_test() {
  1
  |> should.equal(1)
}
