//// src/grid.gleam
////
//// Module: grid
////
//// In this module, the Grid type and its functions are defined.
//// A grid is a continuous infinite two dimensional plane of locations.
//// Each location has a single cell associated with it, either dead or alive.
//// In order to represent infinite space we assume any location that is not accounted for has a dead cell.
//// We only need to keep track of alive cells and their imidiate neighbours in order to determine the next state of the grid.
////
//// API:
//// - Grid
//// - new(Option(List(Cell))) -> Grid
//// - get_cell(Grid, Location) -> Cell
//// - add_cell(Grid, Cell) -> Grid
//// - get_transient_state(Grid) -> List(Cell)
//// Internal:
//// - revive(Grid, Location) -> Grid
//// - kill(Grid, Location) -> Grid
//// - todo
//// - make_proper(List(Cell)) -> List(Cell)

// External imports:
import gleam/list as lis
import gleam/option.{type Option} as opt

// Local imports:
import cell.{type Cell} as cel
import lib
import location.{type Location}

// Public:

/// Grid type definition.
pub opaque type Grid {
  Grid(state: List(Cell))
}

/// Create a new grid.
pub fn new(state: Option(List(Cell))) -> Grid {
  case state {
    opt.Some(state) -> Grid(make_proper(state))
    opt.None -> Grid([])
  }
}

/// Get a cell at a location in the grid.
pub fn get_cell(grid: Grid, location: Location) -> Cell {
  let alive_cell = cel.Alive(location)
  case lis.contains(grid.state, alive_cell) {
    True -> alive_cell
    False -> cel.Dead(location)
  }
}

/// Add a cell to the grid and return a new grid with the cell added.
/// If the cell is already in the grid, it will get overwritten.
pub fn add_cell(grid: Grid, cell: Cell) -> Grid {
  case cel.is_alive(cell) {
    True -> revive(grid, cell.location)
    False -> kill(grid, cell.location)
  }
}

/// Get the grid with all the cells that are alive and their imidiate dead neighbours.
/// This is used to determine the next state of the grid.
/// We call this state transient and it is the only time a grid includes dead cells.
pub fn get_transient_state(grid: Grid) -> List(Cell) {
  todo
}

// Private:

fn revive(grid: Grid, location: Location) -> Grid {
  let alive_cell = cel.Alive(location)
  case lis.contains(grid.state, alive_cell) {
    True -> grid
    False -> Grid([alive_cell, ..grid.state])
  }
}

fn kill(grid: Grid, location: Location) -> Grid {
  let alive_cell = cel.Alive(location)
  case lis.contains(grid.state, alive_cell) {
    True -> Grid(lib.remove(grid.state, alive_cell))
    False -> grid
  }
}

fn get_transient_state_inner() {
  todo
}

fn make_proper(state: List(Cell)) -> List(Cell) {
  todo
}
