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

// Test get population
pub fn get_population_test() -> Nil {
  let raw_grid = [
    c.new(1, 2, True),
    c.new(3, 4, False),
    c.new(5, 6, True),
    c.new(5, 6, True),
    c.new(5, 6, False),
  ]
  let grid = g.new(raw_grid)
  g.get_population(grid)
  |> shld.equal(2)
}

// Test is empty
pub fn is_empty_test() -> Nil {
  let raw_grid = [
    c.new(1, 2, True),
    c.new(3, 4, False),
    c.new(5, 6, True),
    c.new(5, 6, True),
    c.new(5, 6, False),
  ]
  let grid = g.new(raw_grid)
  g.is_empty(grid)
  |> shld.equal(False)
  let empty_grid = g.new([])
  g.is_empty(empty_grid)
  |> shld.equal(True)
}

// Test get cell
pub fn get_cell_test() -> Nil {
  let raw_grid = [
    c.new(1, 2, True),
    c.new(3, 4, False),
    c.new(5, 6, True),
    c.new(5, 6, True),
    c.new(5, 6, False),
  ]
  let grid = g.new(raw_grid)
  g.get_cell(grid, 1, 2)
  |> shld.equal(c.Alive(1, 2))
  g.get_cell(grid, 3, 4)
  |> shld.equal(c.Dead(3, 4))
}

// Test get neighbours
pub fn get_neighbours_test() -> Nil {
  let raw_grid = [
    c.new(1, 2, True),
    c.new(0, 1, False),
    c.new(0, 2, True),
    c.new(2, 3, True),
    c.new(2, 2, False),
  ]
  let grid = g.new(raw_grid)
  g.get_neighbours(grid, 1, 2)
  |> shld.equal([
    c.Dead(0, 1),
    c.Alive(0, 2),
    c.Dead(0, 3),
    c.Dead(1, 1),
    c.Dead(1, 3),
    c.Dead(2, 1),
    c.Dead(2, 2),
    c.Alive(2, 3),
  ])
}
