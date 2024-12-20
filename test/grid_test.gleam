// test/grid_test.gleam

// External imports
import gleeunit as glet
import gleeunit/should as shld

// Local imports
import cell as c
import grid as g

// Public
// Setup
pub fn main() -> Nil {
  glet.main()
}

// Test create new grid
pub fn new_test() -> Nil {
  let raw_grid = [
    c.new(1, 2, True),
    c.new(3, 4, False),
    c.new(5, 6, True),
    c.new(5, 6, True),
    c.new(5, 6, False),
  ]
  let grid = g.new(raw_grid)
  grid
  |> shld.equal([c.Alive(1, 2), c.Alive(5, 6)])
}
