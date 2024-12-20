// test/grid_test.gleam

// External imports
import gleeunit
import gleeunit/should

// Local imports
import cell
import grid

// Public
// Setup
pub fn main() {
  gleeunit.main()
}

// Test create new grid
pub fn new_test() {
  let raw_grid = [
    cell.new(1, 2, True),
    cell.new(3, 4, False),
    cell.new(5, 6, True),
    cell.new(5, 6, True),
    cell.new(5, 6, False),
  ]
  let grid = grid.new(raw_grid)
  grid
  |> should.equal([])
}
