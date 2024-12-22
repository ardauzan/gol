//// test/grid_test.gleam
//// 
//// Module: grid_test
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - produce_proper_grid_test() -> Nil
//// - produce_transient_grid_test() -> Nil
//// - get_alive_neighbour_count_test() -> Nil
//// - remove_redundant_cells_test() -> Nil
//// - remove_dead_cells_test() -> Nil
//// Internal:
//// * None

// External imports
import gleeunit as glet
import gleeunit/should as shld

// Local imports
import cell as c
import grid as g

// Public

/// Setup for testing
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
  g.new(raw_grid)
  |> shld.equal([c.Alive(1, 2), c.Alive(5, 6)])
}

// Test produce proper grid
pub fn produce_proper_grid_test() -> Nil {
  let raw_grid = [
    c.new(1, 2, True),
    c.new(3, 4, False),
    c.new(5, 6, True),
    c.new(5, 6, True),
    c.new(5, 6, False),
  ]
  g.produce_proper_grid(raw_grid)
  |> shld.equal([c.Alive(1, 2), c.Alive(5, 6)])
}

// Test produce transient grid
pub fn produce_transient_grid_test() -> Nil {
  let raw_grid1 = [
    c.new(1, 2, True),
    c.new(3, 4, False),
    c.new(5, 6, True),
    c.new(5, 6, True),
    c.new(5, 6, False),
  ]
  let grid1 = g.new(raw_grid1)
  let raw_grid2 = [c.new(0, 0, True), c.new(1, 0, True)]
  let grid2 = g.new(raw_grid2)
  g.produce_transient_grid(grid1)
  |> shld.equal([
    c.Alive(1, 2),
    c.Alive(5, 6),
    c.Dead(0, 1),
    c.Dead(0, 2),
    c.Dead(0, 3),
    c.Dead(1, 1),
    c.Dead(1, 3),
    c.Dead(2, 1),
    c.Dead(2, 2),
    c.Dead(2, 3),
    c.Dead(4, 5),
    c.Dead(4, 6),
    c.Dead(4, 7),
    c.Dead(5, 5),
    c.Dead(5, 7),
    c.Dead(6, 5),
    c.Dead(6, 6),
    c.Dead(6, 7),
  ])
  g.produce_transient_grid(grid2)
  |> shld.equal([
    c.Alive(0, 0),
    c.Alive(1, 0),
    c.Dead(-1, -1),
    c.Dead(-1, 0),
    c.Dead(-1, 1),
    c.Dead(0, -1),
    c.Dead(0, 1),
    c.Dead(1, -1),
    c.Dead(1, 1),
    c.Dead(2, -1),
    c.Dead(2, 0),
    c.Dead(2, 1),
  ])
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
  g.get_cell_at_location(grid, 1, 2)
  |> shld.equal(c.Alive(1, 2))
  g.get_cell_at_location(grid, 3, 4)
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
  g.get_neighbourhood(grid, c.Alive(1, 2))
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
