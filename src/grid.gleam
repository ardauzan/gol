//// src/grid.gleam
////
//// Module: grid
////
//// In this module, Grid and GridState objects, their functions and error types are defined (GridError).
//// A default max_alive_cell_count is defined too.
////
//// API:
//// - GridError: InvalidMaxAliveCellCount | MaxAliveCellCountExceeded
//// - GridState: List(Cell)
//// - Grid: Grid(GridState, Int) (Opaque)
//// - new(Option(GridState), Option(Int)) -> Result(Grid, GridError)
//// - get_state(Grid) -> GridState
//// - get_max_alive_cell_count(Grid) -> Int
//// - get_cell(Grid, Location) -> Cell
//// - get_neighbours(Grid, Location) -> GridState
//// - get_transient_state(Grid) -> GridState
//// - add_cell(Grid, Cell) -> Result(Grid, GridError)
//// Internal:
//// - default_max_alive_cell_count: Int
//// - get_cell_inner(GridState, Location) -> Cell
//// - get_neighbours_inner(GridState, Location) -> GridState
//// - get_transient_state_inner(GridState, GridState, GridState) -> GridState
//// - sort(GridState) -> GridState
//// - revive(Grid, Location) -> Result(Grid, GridError)
//// - kill(Grid, Location) -> Grid

// Non-local imports:
import gleam/list as lis
import gleam/option.{type Option} as opt

// Local imports:
import cell.{type Cell} as cel
import location.{type Location} as loc

// Public:

/// Errors for the grid module.
/// InvalidMaxAliveCellCount means that the max_alive_cell_count value is invalid.
pub type GridError {
  InvalidMaxAliveCellCount
  MaxAliveCellCountExceeded
}

/// A GridState is any list of Cells.
/// It might be considered proper or not.
/// If it is proper, that means it contains no duplicates, no conflicts, only alive cells and is sorted.
/// If it is not proper, It might have duplicates, conflicts, unrelated dead cells or could be unsorted.
/// It could also be transient which means that it contains only alive cells with their dead neighbours and is sorted.
/// Any proper or transient GridState represents an infinite amount of cells at unique locations, any unincluded cells are considered dead.
pub type GridState =
  List(Cell)

/// A Grid has a state that is a proper GridState.
/// It also has a max_alive_cell_count value which is the maximum number of alive cells in the Grid;
/// This is put in place to be able to cap the growth of the Grid.
/// The max_alive_cell_count value can be any integer greater than or equal to -1;
/// If it is set to -1, there is no limit on the number of alive cells in the Grid (dangerous).
/// If it is set to any integer greater than -1, the Grid will be capped at that number of alive cells.
/// It is defined as an opaque type to prevent direct access to the state so that the state can be properly managed.
pub opaque type Grid {
  Grid(state: GridState, max_alive_cell_count: Int)
}

/// Creates a new Grid with the given state and max_alive_cell_count.
/// If the state is not given, it will be an empty list.
/// If the max_alive_cell_count is not given, it will be the default max_alive_cell_count defined by the module.
/// If the max_alive_cell_count is invalid, it will return an error.
pub fn new(
  state: Option(GridState),
  max_alive_cell_count: Option(Int),
) -> Result(Grid, GridError) {
  let proper_state: GridState = case state {
    opt.Some(state) -> sort(lis.unique(lis.filter(state, cel.is_alive)))
    opt.None -> []
  }
  let max_alive_cell_count_or_error: Result(Int, GridError) = case
    max_alive_cell_count
  {
    opt.Some(given_argument) ->
      case given_argument {
        number if number >= -1 -> Ok(number)
        _ -> Error(InvalidMaxAliveCellCount)
      }
    opt.None -> Ok(default_max_alive_cell_count)
  }
  case max_alive_cell_count_or_error {
    Ok(valid_max_alive_cell_count) ->
      Ok(Grid(proper_state, valid_max_alive_cell_count))
    Error(error) -> Error(error)
  }
}

/// Gets the state of the Grid.
/// As the Grid type is opaque, this is the only way to get the state.
pub fn get_state(grid: Grid) -> GridState {
  grid.state
}

/// Gets the max_alive_cell_count of the Grid.
/// As the Grid type is opaque, this is the only way to get the max_alive_cell_count.
pub fn get_max_alive_cell_count(grid: Grid) -> Int {
  grid.max_alive_cell_count
}

/// Gets a Cell at a Location in the Grid.
pub fn get_cell(grid: Grid, location: Location) -> Cell {
  get_cell_inner(grid.state, location)
}

/// Gets neighbours of a Cell in a Grid.
/// The result does not include the Cell itself only its neighbours!
/// The result is sorted from top to bottom, left to right.
pub fn get_neighbours(grid: Grid, location: Location) -> GridState {
  get_neighbours_inner(grid.state, location)
}

/// Get the transient state of the Grid's state.
pub fn get_transient_state(grid: Grid) -> GridState {
  lis.unique(lis.append(
    grid.state,
    get_transient_state_inner(grid.state, grid.state, []),
  ))
}

/// Add a Cell to the Grid and return the resulting Grid.
/// If the Cell is already in the Grid, it will get overwritten.
pub fn add_cell(grid: Grid, cell: Cell) -> Result(Grid, GridError) {
  case cel.is_alive(cell) {
    True -> revive(grid, cell.location)
    False -> Ok(kill(grid, cell.location))
  }
}

// Private:

/// Default max_alive_cell_count value.
const default_max_alive_cell_count: Int = 100_000

/// Get a Cell at a Location in the GridState.
fn get_cell_inner(state: GridState, location: Location) -> Cell {
  let alive_version: Cell = cel.Alive(location)
  case lis.contains(state, alive_version) {
    True -> alive_version
    False -> cel.Dead(location)
  }
}

/// Get neighbours of a cell in a state.
fn get_neighbours_inner(state: GridState, location: Location) -> GridState {
  [
    get_cell_inner(state, loc.Location(location.x - 1, location.y + 1)),
    get_cell_inner(state, loc.Location(location.x, location.y + 1)),
    get_cell_inner(state, loc.Location(location.x + 1, location.y + 1)),
    get_cell_inner(state, loc.Location(location.x - 1, location.y)),
    get_cell_inner(state, loc.Location(location.x + 1, location.y)),
    get_cell_inner(state, loc.Location(location.x - 1, location.y - 1)),
    get_cell_inner(state, loc.Location(location.x, location.y - 1)),
    get_cell_inner(state, loc.Location(location.x + 1, location.y - 1)),
  ]
}

/// Inner function for making the Grid transient.
/// This function is recursive.
fn get_transient_state_inner(
  original_state: GridState,
  unprocessed_part_of_the_original_state: GridState,
  result: GridState,
) -> GridState {
  case unprocessed_part_of_the_original_state {
    [] -> result
    [head, ..tail] ->
      get_transient_state_inner(
        original_state,
        tail,
        lis.append(result, get_neighbours_inner(original_state, head.location)),
      )
  }
}

/// Sorts a GridState.
/// The result is sorted from top to bottom, left to right.
fn sort(state: GridState) -> GridState {
  todo
}

/// Inner function for reviving a cell.
fn revive(grid: Grid, location: Location) -> Result(Grid, GridError) {
  let alive_version: Cell = cel.Alive(location)
  let current_alive_count: Int = lis.length(grid.state)
  // This is computed here because functions can't be called in guards.
  case lis.contains(grid.state, alive_version) {
    True -> Ok(grid)
    False
      if grid.max_alive_cell_count == -1
      || current_alive_count < grid.max_alive_cell_count
    -> Ok(Grid(..grid, state: sort([alive_version, ..grid.state])))
    _ -> Error(MaxAliveCellCountExceeded)
  }
}

/// Inner function for killing a cell.
fn kill(grid: Grid, location: Location) -> Grid {
  let alive_version: Cell = cel.Alive(location)
  case lis.contains(grid.state, alive_version) {
    True ->
      Grid(
        ..grid,
        state: lis.filter(grid.state, fn(e: Cell) -> Bool { e != alive_version }),
      )
    False -> grid
  }
}
