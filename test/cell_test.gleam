// test/cell_test.gleam

// External imports
import gleeunit
import gleeunit/should

// Local imports
import cell

// Public
// Setup
pub fn main() -> Nil {
  gleeunit.main()
}

// Test create new cell
pub fn new_test() -> Nil {
  cell.new(1, 2, True)
  |> should.equal(cell.Alive(1, 2))
  cell.new(3, 4, False)
  |> should.equal(cell.Dead(3, 4))
}

// Test check if a cell is alive
pub fn is_alive_test() -> Nil {
  let cell = cell.Alive(0, 0)
  cell.is_alive(cell)
  |> should.equal(True)
}

// Test check if a cell is dead
pub fn is_dead_test() -> Nil {
  let cell = cell.Dead(0, 0)
  cell.is_dead(cell)
  |> should.equal(True)
}

// Test get x of cell
pub fn get_x_test() -> Nil {
  let cell1 = cell.Alive(1, 0)
  let cell2 = cell.Dead(0, 1)
  let cell3 = cell.Alive(0, 1)
  let cell4 = cell.Dead(1, 0)
  cell.get_x(cell1)
  |> should.equal(1)
  cell.get_x(cell2)
  |> should.equal(0)
  cell.get_x(cell3)
  |> should.equal(0)
  cell.get_x(cell4)
  |> should.equal(1)
}

// Test get y of cell
pub fn get_y_test() -> Nil {
  let cell1 = cell.Alive(0, 1)
  let cell2 = cell.Dead(1, 0)
  let cell3 = cell.Alive(1, 0)
  let cell4 = cell.Dead(0, 1)
  cell.get_y(cell1)
  |> should.equal(1)
  cell.get_y(cell2)
  |> should.equal(0)
  cell.get_y(cell3)
  |> should.equal(0)
  cell.get_y(cell4)
  |> should.equal(1)
}
