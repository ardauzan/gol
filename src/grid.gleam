//// src/grid.gleam
////
//// Module: grid
////
//// In this module, the Grid type and its functions are defined.
//// A grid is a continuous infinite two dimensional plane of locations.
//// Each location has a single cell associated with it, either dead or alive.
//// In oreder to represent infinite space we assume any location that is not accounted for has a dead cell.
//// We only need to keep track of alive cells and their imidiate neighbours in order to determine the next state of the grid.
//// We should also make it so that no two cells have the same location, if they conflict thats a logic error and if they don't it's redundant.
////
//// API:
//// - GridError
//// - Grid
//// - new() -> Grid
//// - add(Grid, Cell) -> Grid
//// - get(Grid, Location) -> Cell
//// - make_proper(Grid) -> Grid
//// - make_transient(Grid) -> Grid
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

/// GridError type definition.
/// A grid error is an error that occurs when a grid gets acted on incorrectly.
pub type GridError {
  ConflictingCellExistsError
  RedundantCellExistsError
  CellNotFoundError
}

/// Grid type definition.
/// A grid is a list of cells.
/// It can be in the form of three different states.
/// 1. Proper     | Only contains unique alive cells or is empty.
/// 2. Transient  | Contains alive or dead cells but no two cells have the same location.
/// 3. Invalid    | Any state that is not proper or transient. (The grid either has conflicting or redundant data.)
/// Only way for a grid to be invalid is if it was constructed manually, not through any of the functions in this module.
pub type Grid =
  List(cel.Cell)

/// Grid constructor.
pub fn new() -> Grid {
  []
}

/// Add cell to grid.
/// If the cell conflicts with another cell in the grid, an error will be thrown.
/// If the cell is already in the grid, an error will be thrown.
/// If the cell is not conflicting and not in the grid, it will be added.
pub fn add(grid: Grid, cell: cel.Cell) -> Result(Grid, GridError) {
  case cell_conflicts(grid, cell) {
    True -> Error(ConflictingCellExistsError)
    False ->
      case lis.contains(grid, cell) {
        True -> Error(RedundantCellExistsError)
        False -> Ok(lis.append(grid, [cell]))
      }
  }
}

/// Get cell at location.
pub fn get(grid: Grid, location: loc.Location) -> cel.Cell {
  let cell_alive = cel.new(location, True)
  case lis.contains(make_proper(grid), cell_alive) {
    True -> cell_alive
    False -> cel.new(location, False)
  }
}

/// Make the grid proper.
pub fn make_proper(grid: Grid) -> Grid {
  lis.unique(remove_dead(grid))
}

/// Make the grid transient.
/// We first make the grid proper and then add the dead neighbours of the alive cells.
pub fn make_transient(grid: Grid) -> Grid {
  let proper_grid = make_proper(grid)
  lis.unique(
    lis.flatten([
      proper_grid,
      make_transient_inner(proper_grid, proper_grid, []),
    ]),
  )
}

/// Remove cell from grid.
/// If the cell is not in the grid, an error will be thrown.
pub fn remove_at_location(
  grid: Grid,
  location: loc.Location,
) -> Result(Grid, GridError) {
  let alive_cell = cel.new(location, True)
  let dead_cell = cel.new(location, False)
  case lis.contains(grid, alive_cell) {
    True -> Ok(lib.remove(grid, alive_cell))
    False ->
      case lis.contains(grid, dead_cell) {
        True -> Ok(lib.remove(grid, dead_cell))
        False -> Error(CellNotFoundError)
      }
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
