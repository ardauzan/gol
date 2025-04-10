//// src/grid.gleam
////
//// Module: grid
////
//// In this module, Grid object, its functions and errors are defined.
//// A Grid has a state that is a proper GridState.
//// It also has a max_alive_cell_count value which is the maximum number of alive cells in the Grid;
//// This is put in place to be able to cap the growth of the Grid.
//// The max_alive_cell_count value can be any integer greater than or equal to -1;
//// If it is set to -1, there is no limit on the number of alive cells in the Grid (dangerous).
//// If it is set to any integer greater than -1, the Grid will be capped at that number of alive cells.
//// It is defined as an opaque type to prevent direct access to the state so that it can be safely managed and kept in the proper form.
//// 
//// API:
//// - GridError: InvalidMaxAliveCellCount | MaxAliveCellCountExceeded
//// - GridState: List(Cell)
//// - Grid: Grid(GridState, Int) (Opaque)
//// - default_max_alive_cell_count: Int
//// - new(Option(GridState), Option(Int)) -> Result(Grid, GridError)
//// - get_state(Grid) -> GridState
//// - get_max_alive_cell_count(Grid) -> Int
//// - get_cell(Grid, Location) -> Cell
//// - get_neighbours(Grid, Location) -> GridState
//// - get_transient_state_unsorted(Grid) -> GridState
//// - get_transient_state_sorted(Grid) -> GridState
//// - add_cell(Grid, Cell) -> Result(Grid, GridError)
//// Internal:
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
/// InvalidMaxAliveCellCount means that the max_alive_cell_count value given to the new function is invalid.
/// MaxAliveCellCountExceeded means that the max_alive_cell_count value has been exceeded, either in the new function or in the add_cell function.
pub type GridError {
  InvalidMaxAliveCellCount
  MaxAliveCellCountExceeded
}

/// A GridState is any list of Cells.
/// It might be considered proper or not.
/// If it is proper, that means it contains no duplicates, no conflicts, only alive cells and is sorted from bottom to top, left to right.
/// If it is not proper, It might have duplicates, conflicts, unrelated dead cells or could be unsorted.
/// It could also be transient which means that it contains only unique Cells which are alive cells with their dead neighbours and is sorted or unsorted.
/// Any proper or transient GridState represents an infinite amount of cells, one at each Location on a 2D plane, any unincluded cells are considered dead.
pub type GridState =
  List(Cell)

/// A Grid has a state that is a proper GridState.
/// It also has a max_alive_cell_count value which is the maximum number of alive cells in the Grid;
/// This is put in place to be able to cap the growth of the Grid.
/// The max_alive_cell_count value can be any integer greater than or equal to -1;
/// If it is set to -1, there is no limit on the number of alive cells in the Grid (dangerous).
/// If it is set to any integer greater than -1, the Grid will be capped at that number of alive cells.
/// It is defined as an opaque type to prevent direct access to the state so that it can be safely managed and kept in the proper form.
pub opaque type Grid {
  Grid(state: GridState, max_alive_cell_count: Int)
}

/// Default max_alive_cell_count value.
/// Not having one seems dangerous...
pub const default_max_alive_cell_count: Int = 10_000_000

/// Creates a new Grid with the given GridState and max_alive_cell_count.
/// If a GridState is not given, it will be an empty list.
/// If the max_alive_cell_count is not given, it will be the default max_alive_cell_count defined by the module.
/// If the max_alive_cell_count is invalid, which means it is less than -1, it will return an error.
/// If the given GridState's proper forms length is greater than the max_alive_cell_count, it will return an error.
pub fn new(
  state: Option(GridState),
  max_alive_cell_count: Option(Int),
) -> Result(Grid, GridError) {
  let proper_state: GridState = case state {
    opt.Some(state) -> sort(lis.unique(lis.filter(state, cel.is_alive)))
    opt.None -> []
  }
  let length_of_proper_state: Int = lis.length(proper_state)
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
      case valid_max_alive_cell_count {
        -1 -> Ok(Grid(proper_state, -1))
        number if number >= length_of_proper_state ->
          Ok(Grid(proper_state, number))
        _ -> Error(MaxAliveCellCountExceeded)
      }
    Error(error) -> Error(error)
  }
}

/// Gets the GridState of the Grid.
/// As the Grid type is opaque, this is the only way to get the state of the Grid.
pub fn get_state(grid: Grid) -> GridState {
  grid.state
}

/// Gets the max_alive_cell_count of the Grid.
/// As the Grid type is opaque, this is the only way to get the max_alive_cell_count of the Grid.
pub fn get_max_alive_cell_count(grid: Grid) -> Int {
  grid.max_alive_cell_count
}

/// Gets a Cell at a Location in the Grid.
pub fn get_cell(grid: Grid, location: Location) -> Cell {
  get_cell_inner(grid.state, location)
}

/// Gets neighbours of a Cell in a Grid.
/// The result does not include the Cell itself only its neighbours!
/// The result is sorted from bottom to top and then left to right but not by state.
pub fn get_neighbours(grid: Grid, location: Location) -> GridState {
  get_neighbours_inner(grid.state, location)
}

/// Gets the transient GridState of the Grid as unsorted.
/// The transient GridState is the list of cells that has a chance of getting toggled after a tick.
/// We don't need it to be sorted to work with it thats why this function exists.
/// There is no point in sorting the list for no reason in the tick function as the processed results are sorted as they get inserted into the Grid.
pub fn get_transient_state_unsorted(grid: Grid) -> GridState {
  let state: GridState = grid.state
  get_transient_state_inner(state, state, [])
}

/// Gets the transient GridState of the Grid as sorted.
/// The transient GridState is the list of cells that has a chance of getting toggled after a tick.
/// If for some reason you want this sorted, this is the function to use.
pub fn get_transient_state_sorted(grid: Grid) -> GridState {
  sort(get_transient_state_unsorted(grid))
}

/// Adds a Cell to the Grid and returns the resulting Grid.
/// If the Cell is already in the Grid, it will get overwritten.
/// This will preserve the proper form of the state by keeping the sort order.
/// If the Grid state is full, and this function tries to add a Cell, it will return an error.
pub fn add_cell(grid: Grid, cell: Cell) -> Result(Grid, GridError) {
  let location: Location = cell.location
  case cel.is_alive(cell) {
    True -> revive(grid, location)
    False -> Ok(kill(grid, location))
  }
}

// Private:

/// Inner function to get a Cell in a GridState.
fn get_cell_inner(state: GridState, location: Location) -> Cell {
  let alive_version: Cell = cel.Alive(location)
  case lis.contains(state, alive_version) {
    True -> alive_version
    False -> cel.Dead(location)
  }
}

/// Inner function to get neighbours of a Cell in a GridState.
fn get_neighbours_inner(state: GridState, location: Location) -> GridState {
  let x: Int = location.x
  let y: Int = location.y
  [
    get_cell_inner(state, loc.Location(x - 1, y - 1)),
    get_cell_inner(state, loc.Location(x, y - 1)),
    get_cell_inner(state, loc.Location(x + 1, y - 1)),
    get_cell_inner(state, loc.Location(x - 1, y)),
    get_cell_inner(state, loc.Location(x + 1, y)),
    get_cell_inner(state, loc.Location(x - 1, y + 1)),
    get_cell_inner(state, loc.Location(x, y + 1)),
    get_cell_inner(state, loc.Location(x + 1, y + 1)),
  ]
}

/// Inner function for making the GridState transient.
fn get_transient_state_inner(
  original_state: GridState,
  unprocessed_part_of_the_original_state: GridState,
  result: GridState,
) -> GridState {
  case unprocessed_part_of_the_original_state {
    [] -> lis.unique(lis.append(original_state, result))
    [head, ..tail] ->
      get_transient_state_inner(
        original_state,
        tail,
        lis.append(result, get_neighbours_inner(original_state, head.location)),
      )
  }
}

/// Sorts a GridState.
fn sort(state: GridState) -> GridState {
  lis.sort(state, cel.compare)
}

/// Inner function for reviving a Cell.
fn revive(grid: Grid, location: Location) -> Result(Grid, GridError) {
  let state: GridState = grid.state
  let alive_version: Cell = cel.Alive(location)
  let current_alive_cell_count: Int = lis.length(state)
  let max_alive_cell_count: Int = grid.max_alive_cell_count
  case lis.contains(state, alive_version) {
    True -> Ok(grid)
    False
      if max_alive_cell_count == -1
      || current_alive_cell_count < max_alive_cell_count
    -> Ok(Grid(..grid, state: sort([alive_version, ..state])))
    _ -> Error(MaxAliveCellCountExceeded)
  }
}

/// Inner function for killing a Cell.
fn kill(grid: Grid, location: Location) -> Grid {
  Grid(
    ..grid,
    state: lis.filter(grid.state, fn(e: Cell) -> Bool {
      e != cel.Alive(location)
    }),
  )
}
