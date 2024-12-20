// src/grid.gleam

// External imports
import gleam/list

// Local imports
import cell as c

// Public
// Grid type definition
// A grid is a one dimensional list of cells
// A grid can be in three states:
// 1. Proper grid: A grid without conflicts or redundancy, this is the starting and ending state
// 2. Transient grid: A grid without conflicts but with redundancy, this is the intermediate state between proper grid states
// 3. CorruptedGrid: A grid with conflicts and possibly redundancy, this is an error state as it has multiple cells with the same location and they are not the same -
// state, which is not possible
// We cant enforce constraints on values in the gleam typesystem therefore we define the type as a list of cells and check for conflicts and redundancy in the runtime
pub type Grid =
  List(c.Cell)

// Function to create a new grid, we assume it has both conflicts and redundancy to sanitize the input data, it is important to not define an instance of a grid outs-
// ide this function
// Other public functions in this module will assume that you have created your grid with this function, additional checks wont be performed for conflicts and this m-
// ay cause undefined behaviour if not followed
pub fn new(raw_grid: Grid) -> Grid {
  let grid1 = remove_redundant_cells(raw_grid)
  remove_dead_cells(grid1)
}

// Get alive cell count, (can be used with proper and transient grids)
pub fn get_population(grid: Grid) -> Int {
  list.fold(grid, 0, fn(acc: Int, cell: c.Cell) -> Int {
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
    list.filter(grid, fn(cell: c.Cell) -> Bool { cell.x == x && cell.y == y })
  case res {
    [] -> c.Dead(x, y)
    [cell, ..] -> cell
  }
}

// Private
// Remove redundant cells meaning cells with the same x, y and state
fn remove_redundant_cells(raw_grid: Grid) -> Grid {
  list.unique(raw_grid)
}

// Remove dead cells meaning cells that are not alive
fn remove_dead_cells(raw_grid: Grid) -> Grid {
  list.filter(raw_grid, fn(cell: c.Cell) -> Bool { c.is_alive(cell) })
}

// Get the neighbourhood of a cell in the form of a proper grid
fn get_neighbours(grid: Grid, x: Int, y: Int) -> Grid {
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
