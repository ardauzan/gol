// test/cell_test.gleam

// External imports
import gleeunit
import gleeunit/should

// Local imports
import cell as c

// Public
// Setup
pub fn main() -> Nil {
  gleeunit.main()
}

// Test create new cell
pub fn new_test() -> Nil {
  c.new(1, 2, True)
  |> should.equal(c.Alive(1, 2))
  c.new(3, 4, False)
  |> should.equal(c.Dead(3, 4))
}

// Test check if a cell is alive
pub fn is_alive_test() -> Nil {
  let cell = c.Alive(0, 0)
  c.is_alive(cell)
  |> should.equal(True)
}

// Test check if a cell is dead
pub fn is_dead_test() -> Nil {
  let cell = c.Dead(0, 0)
  c.is_dead(cell)
  |> should.equal(True)
}

// Test get x of cell
pub fn get_x_test() -> Nil {
  let cell1 = c.Alive(1, 0)
  let cell2 = c.Dead(0, 1)
  let cell3 = c.Alive(0, 1)
  let cell4 = c.Dead(1, 0)
  c.get_x(cell1)
  |> should.equal(1)
  c.get_x(cell2)
  |> should.equal(0)
  c.get_x(cell3)
  |> should.equal(0)
  c.get_x(cell4)
  |> should.equal(1)
}

// Test get y of cell
pub fn get_y_test() -> Nil {
  let cell1 = c.Alive(0, 1)
  let cell2 = c.Dead(1, 0)
  let cell3 = c.Alive(1, 0)
  let cell4 = c.Dead(0, 1)
  c.get_y(cell1)
  |> should.equal(1)
  c.get_y(cell2)
  |> should.equal(0)
  c.get_y(cell3)
  |> should.equal(0)
  c.get_y(cell4)
  |> should.equal(1)
}
