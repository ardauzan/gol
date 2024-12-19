import gleam/io

pub type Cell {
  Alive(x: Int, y: Int)
  Dead(x: Int, y: Int)
}

pub type Grid =
  List(Cell)

pub fn main() {
  let init_grid: Grid = []
  io.println("Hello from gol!")
}
