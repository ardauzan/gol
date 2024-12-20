// src/grid.gleam

// External imports
import gleam/list as l

// Local imports
import cell as c

// Public
// Grid type definition
// A grid is a one dimensional list of cells
// A grid can be in one of three states:
// 1. Proper grid: A grid without any dead cells and no redundancy
// 2. Transient grid: A grid without redundancy but with relevant dead cells (neighbourhood added)
// 3. CorruptedGrid: A grid with conflicts and/or redundancy, this is an error state as it has multiple cells with the same location and they are possibly conflictin-
// g as in the case of a live cell and a dead cell with the same location
// We cant enforce constraints on values in the gleam typesystem therefore we define the type as a list of cells and check for conflicts and redundancy in the runtime
pub type Grid =
  List(c.Cell)

// Function to create a new grid, we assume it has both conflicts and redundancy to sanitize the input data, it is important to not define an instance of a grid outs-
// ide this function
// Other public functions in this module will assume that you have created your grid with this function, additional checks wont be performed for conflicts and this m-
// ay cause undefined behaviour if not followed
pub fn new(raw_grid: Grid) -> Grid {
  produce_proper_grid(raw_grid)
}

// Get alive cell count, (can be used with proper and transient grids)
pub fn get_population(grid: Grid) -> Int {
  l.fold(grid, 0, fn(acc: Int, cell: c.Cell) -> Int {
    acc
    + case c.is_alive(cell) {
      True -> 1
      False -> 0
    }
  })
}

// Get if the grid is empty, (can be used with proper and transient grids)
pub fn is_empty(grid: Grid) -> Bool {
  get_population(grid) == 0
}

// Get the state of a cell, (can be used with proper and transient grids)
pub fn get_cell(grid: Grid, x: Int, y: Int) -> c.Cell {
  let res =
    l.filter(grid, fn(cell: c.Cell) -> Bool { cell.x == x && cell.y == y })
  case res {
    [] -> c.Dead(x, y)
    [cell, ..] -> cell
  }
}

// Get the neighbourhood of a cell in the form of a proper grid
pub fn get_neighbours(grid: Grid, x: Int, y: Int) -> Grid {
  [
    get_cell(grid, x - 1, y - 1),
    get_cell(grid, x - 1, y),
    get_cell(grid, x - 1, y + 1),
    get_cell(grid, x, y - 1),
    get_cell(grid, x, y + 1),
    get_cell(grid, x + 1, y - 1),
    get_cell(grid, x + 1, y),
    get_cell(grid, x + 1, y + 1),
  ]
}

// Add the neighbourhood of each cell to the grid to make a transient grid, (only use with proper grids)
pub fn add_neighbours(grid: Grid) -> Grid {
  produce_transient_grid(grid)
}

// Private
// Remove dead cells meaning cells that are not alive
fn remove_dead_cells(raw_grid: Grid) -> Grid {
  l.filter(raw_grid, fn(cell: c.Cell) -> Bool { c.is_alive(cell) })
}

// Produce a proper grid from a transient grid or a corrupted grid
fn produce_proper_grid(raw_grid: Grid) -> Grid {
  let unique_raw_grid = l.unique(raw_grid)
  remove_dead_cells(unique_raw_grid)
}

// Produce a transient grid from a proper grid to be able to process it and get the next generation
fn produce_transient_grid(grid: Grid) -> Grid {
  todo
}
