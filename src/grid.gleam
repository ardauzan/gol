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
//// - GridState
//// - Grid
//// - new(Option(GridState)) -> Grid
//// - add_cell(Grid, Cell) -> Grid
//// - get_state(Grid) -> GridState
//// - get_neighbours_from_grid(Grid, Location) -> GridState
//// - get_neighbours_from_state(GridState, Location) -> GridState
//// - get_transient_state(Grid) -> GridState
//// - get_cell_from_grid(Grid, Location) -> Cell
//// - get_cell_from_state(GridState, Location) -> Cell
//// Internal:
//// - revive(Grid, Location) -> Grid
//// - kill(Grid, Location) -> Grid
//// - get_transient_state_inner(GridState, GridState, GridState) -> GridState
//// - make_proper(GridState) -> GridState

// External imports:
import gleam/list as lis
import gleam/option.{type Option} as opt

// Local imports:
import cell.{type Cell} as cel
import lib
import location.{type Location} as loc

// Public:

/// Type alias for a grid state.
pub type GridState =
  List(Cell)

/// Grid type definition.
pub opaque type Grid {
  Grid(state: GridState)
}

/// Create a new grid.
pub fn new(state: Option(GridState)) -> Grid {
  case state {
    opt.Some(state) -> Grid(make_proper(state))
    opt.None -> Grid([])
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

/// Get the state of the grid.
/// As the Grid type is opaque, this is the only way to get the state.
pub fn get_state(grid: Grid) -> GridState {
  grid.state
}

/// Get neighbours of a cell in a grid.
pub fn get_neighbours_from_grid(grid: Grid, location: Location) -> GridState {
  let x = location.x
  let y = location.y
  [
    get_cell_from_grid(grid, loc.Location(x - 1, y + 1)),
    get_cell_from_grid(grid, loc.Location(x, y + 1)),
    get_cell_from_grid(grid, loc.Location(x + 1, y + 1)),
    get_cell_from_grid(grid, loc.Location(x - 1, y)),
    get_cell_from_grid(grid, loc.Location(x + 1, y)),
    get_cell_from_grid(grid, loc.Location(x - 1, y - 1)),
    get_cell_from_grid(grid, loc.Location(x, y - 1)),
    get_cell_from_grid(grid, loc.Location(x + 1, y - 1)),
  ]
}

/// Get neighbours of a cell in a state.
pub fn get_neighbours_from_state(
  state: GridState,
  location: Location,
) -> GridState {
  let x = location.x
  let y = location.y
  [
    get_cell_from_state(state, loc.Location(x - 1, y + 1)),
    get_cell_from_state(state, loc.Location(x, y + 1)),
    get_cell_from_state(state, loc.Location(x + 1, y + 1)),
    get_cell_from_state(state, loc.Location(x - 1, y)),
    get_cell_from_state(state, loc.Location(x + 1, y)),
    get_cell_from_state(state, loc.Location(x - 1, y - 1)),
    get_cell_from_state(state, loc.Location(x, y - 1)),
    get_cell_from_state(state, loc.Location(x + 1, y - 1)),
  ]
}

/// Get the grid with all the cells that are alive and their imidiate dead neighbours.
/// This is used to determine the next state of the grid.
pub fn get_transient_state(grid: Grid) -> GridState {
  let proper_state = make_proper(grid.state)
  lis.unique(lis.append(
    proper_state,
    get_transient_state_inner(proper_state, proper_state, []),
  ))
}

/// Get a cell at a location in the grid.
pub fn get_cell_from_grid(grid: Grid, location: Location) -> Cell {
  let alive_cell = cel.Alive(location)
  case lis.contains(grid.state, alive_cell) {
    True -> alive_cell
    False -> cel.Dead(location)
  }
}

/// Get a cell at a location in the grid state.
pub fn get_cell_from_state(state: GridState, location: Location) -> Cell {
  let alive_cell = cel.Alive(location)
  case lis.contains(make_proper(state), alive_cell) {
    True -> alive_cell
    False -> cel.Dead(location)
  }
}

// Private:

/// Inner function for reviving a cell.
fn revive(grid: Grid, location: Location) -> Grid {
  let alive_cell = cel.Alive(location)
  case lis.contains(grid.state, alive_cell) {
    True -> grid
    False -> Grid([alive_cell, ..grid.state])
  }
}

/// Inner function for killing a cell.
fn kill(grid: Grid, location: Location) -> Grid {
  let alive_cell = cel.Alive(location)
  case lis.contains(grid.state, alive_cell) {
    True -> Grid(lib.remove(grid.state, alive_cell))
    False -> grid
  }
}

/// Inner function for making the grid transient.
/// This function is recursive.
fn get_transient_state_inner(
  state: GridState,
  temp1: GridState,
  temp2: GridState,
) -> GridState {
  case temp1 {
    [] -> temp2
    [head, ..tail] ->
      get_transient_state_inner(
        state,
        tail,
        lis.append(temp2, get_neighbours_from_state(state, head.location)),
      )
  }
}

/// Inner function for making the grid proper.
fn make_proper(state: GridState) -> GridState {
  lis.unique(lis.filter(state, cel.is_alive))
}
