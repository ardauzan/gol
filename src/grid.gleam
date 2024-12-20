// src/grid.gleam

// External imports
import gleam/list

// Local imports
import cell

// Public
// Grid type definition
// A grid is a one dimensional list of cells
pub type Grid =
  List(cell.Cell)

// Function to create a new grid, accounting for conflicts and redundancy
pub fn new(raw_grid: Grid) -> Grid {
  produce_proper_grid(raw_grid)
}

// Get alive cell count
pub fn get_population(raw_grid: Grid) -> Int {
  let grid = produce_proper_grid(raw_grid)
  list.fold(grid, 0, fn(acc: Int, cell: cell.Cell) -> Int {
    acc
    + case cell.is_alive(cell) {
      True -> 1
      False -> 0
    }
  })
}

// Get if the grid is empty
pub fn is_empty(raw_grid: Grid) -> Bool {
  let grid = produce_proper_grid(raw_grid)
  get_population(grid) == 0
}

// Get the state of a cell
pub fn get_cell(raw_grid: Grid, x: Int, y: Int) -> cell.Cell {
  let grid = produce_proper_grid(raw_grid)
  let res =
    list.filter(grid, fn(cell: cell.Cell) -> Bool { cell.x == x && cell.y == y })
  case res {
    [] -> cell.Dead(x, y)
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
  list.filter(raw_grid, fn(cell: cell.Cell) -> Bool { cell.is_alive(cell) })
}

// Add neighbours of the cells in the grid to the grid
fn add_neighbours(raw_grid: Grid) -> Grid {
  let get_neighbours = fn(cell: cell.Cell) -> Grid {
    let x = cell.x
    let y = cell.y
    [
      get_cell(raw_grid, x - 1, y - 1),
      get_cell(raw_grid, x - 1, y),
      get_cell(raw_grid, x - 1, y + 1),
      get_cell(raw_grid, x, y - 1),
      get_cell(raw_grid, x, y + 1),
      get_cell(raw_grid, x + 1, y - 1),
      get_cell(raw_grid, x + 1, y),
      get_cell(raw_grid, x + 1, y + 1),
    ]
  }
  let res =
    list.map(raw_grid, fn(cell: cell.Cell) -> Grid { get_neighbours(cell) })
  let raw_neighbours = list.flatten(res)
  let unique_neighbours = remove_redundant_cells(raw_neighbours)
  list.flatten([raw_grid, unique_neighbours])
}

// Produce a proper grid, accounting for conflicts and redundancy
fn produce_proper_grid(raw_grid: Grid) -> Grid {
  let grid1 = remove_redundant_cells(raw_grid)
  let grid2 = remove_dead_cells(grid1)
  add_neighbours(grid2)
}
