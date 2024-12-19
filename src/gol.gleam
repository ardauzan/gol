import gleam/int
import gleam/io
import gleam/list

pub type Cell {
  Alive(x: Int, y: Int)
  Dead
}

pub fn main() {
  let grid: List(Cell) = [Alive(1, 1), Dead]
  io.println("Hello from gol!")
  io.println(int.to_string(list.count(grid, fn(c: Cell) { c == Alive(1, 1) })))
}
