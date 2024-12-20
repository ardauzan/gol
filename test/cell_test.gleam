import gleeunit
import gleeunit/should

import cell

pub fn main() {
  gleeunit.main()
}

pub fn is_alive_test() {
  let cell = cell.Alive(0, 0)
  cell.is_alive(cell)
  |> should.equal(True)
}

pub fn is_dead_test() {
  let cell = cell.Dead(0, 0)
  cell.is_dead(cell)
  |> should.equal(True)
}

pub fn get_x_test() {
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

pub fn get_y_test() {
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
