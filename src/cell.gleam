// src/cell.gleam

// Public
// Cell type definition
// A cell is either alive or dead and has an x and y position
pub type Cell {
  Alive(x: Int, y: Int)
  Dead(x: Int, y: Int)
}

// Function to create a new cell
pub fn new(x: Int, y: Int, is_alive: Bool) -> Cell {
  case is_alive {
    True -> Alive(x, y)
    False -> Dead(x, y)
  }
}

// Get if a cell is alive
pub fn is_alive(cell: Cell) -> Bool {
  case cell {
    Alive(_, _) -> True
    Dead(_, _) -> False
  }
}

// Get if a cell is dead
pub fn is_dead(cell: Cell) -> Bool {
  !is_alive(cell)
}

// Get the x position of a cell
pub fn get_x(cell: Cell) -> Int {
  cell.x
}

// Get the y position of a cell
pub fn get_y(cell: Cell) -> Int {
  cell.y
}
