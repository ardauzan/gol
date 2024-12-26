//// src/grid.gleam
//// 
//// Module: grid
//// API:
//// - Grid
//// - new() -> Grid
//// - is_empty(Grid) -> Bool
//// - add(Grid, Cell) -> Grid
//// - get(Grid, Location) -> Cell
//// - remove_at_location(Grid, Location) -> Grid
//// Internal:
//// - contains(Grid, Cell) -> Bool
//// - remove(Grid, Cell) -> Grid
//// - cell_conflicts(Grid, Cell) -> Bool

// External imports
import gleam/list as lis

// Local imports
import cell as cel
import lib
import location as loc

// Public

/// Grid type definition:
pub type Grid =
  List(cel.Cell)

/// Grid constructor:
pub fn new() -> Grid {
  []
}

/// Get if the grid is empty.
pub fn is_empty(grid: Grid) -> Bool {
  case grid {
    [] -> True
    [_, ..] -> False
  }
}

/// Add cell to grid.
/// If the cell conflicts with another cell in the grid, the cell will not be added.
/// If the cell is already in the grid, it will not be added.
/// If the cell is dead, it will not be actually added.
pub fn add(grid: Grid, cell: cel.Cell) -> Grid {
  case cel.is_alive(cell), cell_conflicts(grid, cel.toggle(cell)) {
    True, True -> grid
    False, _conflict -> grid
    True, False -> lib.add_unique(grid, cell)
  }
}

/// Get cell from grid.
pub fn get(grid: Grid, location: loc.Location) -> cel.Cell {
  let cell_alive = cel.new(location, True)
  let cell_dead = cel.new(location, False)
  let grid_contains_cell_alive = contains(grid, cell_alive)
  case
    grid_contains_cell_alive || contains(grid, cell_dead),
    grid_contains_cell_alive
  {
    True, True -> cell_alive
    True, False -> cell_dead
    False, _grid_contains_cell_alive -> cell_dead
  }
}

/// Remove cell from grid.
pub fn remove_at_location(grid: Grid, location: loc.Location) -> Grid {
  let cell = get(grid, location)
  case contains(grid, cell) {
    True -> remove(grid, cell)
    False -> grid
  }
}

// Private

/// Check if a grid contains a cell.
fn contains(grid: Grid, cell: cel.Cell) -> Bool {
  lis.contains(grid, cell)
}

/// Remove a cell from a grid.
fn remove(grid: Grid, cell_outer: cel.Cell) -> Grid {
  lis.filter(grid, fn(cell_inner: cel.Cell) -> Bool { cell_inner != cell_outer })
}

/// Check if a cell is conflicting with any cell in the grid.
fn cell_conflicts(grid: Grid, cell: cel.Cell) -> Bool {
  contains(grid, cel.toggle(cell))
}
