import gleeunit
import gleeunit/should

import cell
import grid

pub fn main() {
  gleeunit.main()
}

pub fn get_population_test() {
  let grid = [cell.Alive(0, 0)]

  grid.get_population(grid)
  |> should.equal(1)
}
