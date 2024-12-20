// src/grid.gleam
// Stdlib imports
import gleam/list

// Local imports
import cell

// Public
// Grid type definition
// Grid is a one dimensional list of cells
pub type Grid =
  List(cell.Cell)

// Get alive cell count
pub fn get_population(grid: Grid) -> Int {
  list.length(grid)
}

// Get if the grid is empty
pub fn is_empty(grid: Grid) -> Bool {
  get_population(grid) == 0
}

// Get the state of a cell
pub fn get_cell(grid: Grid, x: Int, y: Int) -> cell.Cell {
  todo
}
