//// src/grid.gleam
////
//// Module: grid
////
//// In this module, the Grid type and its functions are defined.
////
//// API:
//// - Grid
//// - new() -> Grid
//// - make_proper(Grid) -> Grid
//// - make_transient(Grid) -> Grid
//// - add(Grid, Cell) -> Grid
//// - get(Grid, Location) -> Cell
//// - remove_at_location(Grid, Location) -> Grid
//// - get_neighbours(Grid, Location) -> Grid
//// Internal:
//// - cell_conflicts(Grid, Cell) -> Bool
//// - remove_dead(Grid) -> Grid
//// - make_transient_inner(Grid, Grid, Grid) -> Grid

// External imports:
import gleam/list as lis

// Local imports:
import cell as cel
import lib
import location as loc

// Public:

/// Grid type definition.
/// A grid is a list of cells.
/// It can be in the form of three different states.
/// 1. Proper     | Only contains unique alive cells or is empty.
/// 2. Transient  | Contains unique alive cells and their dead neighbours.
/// 3. Invalid    | Any state that is not proper or transient.
/// Only way for a grid to be invalid is if it was constructed manually, not through any of the functions in this module.
pub type Grid =
  List(cel.Cell)

/// Grid constructor.
pub fn new() -> Grid {
  []
}

/// Make the grid proper.
pub fn make_proper(grid: Grid) -> Grid {
  lis.unique(remove_dead(grid))
}

/// Make the grid transient.
/// We first make the grid proper and then add the dead neighbours of the alive cells.
pub fn make_transient(grid: Grid) -> Grid {
  let proper_grid = make_proper(grid)
  lis.flatten([proper_grid, make_transient_inner(proper_grid, proper_grid, [])])
}

/// Add cell to grid.
/// If the cell conflicts with another cell in the grid, the cell will not be added.
/// If the cell is already in the grid, it will not be added.
/// If the cell is dead, it will not be actually added.
pub fn add(grid: Grid, cell: cel.Cell) -> Grid {
  case cell_conflicts(grid, cel.toggle(cell)) {
    True -> grid
    False -> lib.add_unique(grid, cell)
  }
}

/// Get cell from grid.
pub fn get(grid: Grid, location: loc.Location) -> cel.Cell {
  let cell_alive = cel.new(location, True)
  let cell_dead = cel.new(location, False)
  let grid_contains_cell_alive = lis.contains(grid, cell_alive)
  case
    grid_contains_cell_alive || lis.contains(grid, cell_dead),
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
  case lis.contains(grid, cell) {
    True -> lib.remove(grid, cell)
    False -> grid
  }
}

/// Get neighbours of cell at location.
pub fn get_neighbours(grid: Grid, location: loc.Location) -> Grid {
  let x = loc.get_x(location)
  let y = loc.get_y(location)
  [
    get(grid, loc.new(x - 1, y - 1)),
    get(grid, loc.new(x - 1, y)),
    get(grid, loc.new(x - 1, y + 1)),
    get(grid, loc.new(x, y - 1)),
    get(grid, loc.new(x, y + 1)),
    get(grid, loc.new(x + 1, y - 1)),
    get(grid, loc.new(x + 1, y)),
    get(grid, loc.new(x + 1, y + 1)),
  ]
}

// Private:

/// Check if a cell is conflicting with any cell in the grid.
fn cell_conflicts(grid: Grid, cell: cel.Cell) -> Bool {
  lis.contains(grid, cel.toggle(cell))
}

/// Remove all dead cells from the grid.
fn remove_dead(grid: Grid) -> Grid {
  lis.filter(grid, cel.is_alive)
}

/// Inner loop for making the grid transient.
fn make_transient_inner(proper_grid: Grid, temp1: Grid, temp2: Grid) -> Grid {
  case temp1 {
    [] -> temp2
    [head, ..tail] ->
      make_transient_inner(
        proper_grid,
        tail,
        lis.unique(
          lis.flatten([
            temp2,
            get_neighbours(proper_grid, cel.get_location(head)),
          ]),
        ),
      )
  }
}
