//// src/tick.gleam
////
//// Module: tick
////
//// In this module, the tick logic and related errors are defined.
//// The tick function takes a Grid and a Ruleset and returns the next Grid after the Ruleset is applied to it a single time.
//// The tick_to function takes a Grid, a Ruleset and a number of times to apply the Ruleset to the Grid and returns the final Grid.
//// 
//// API:
//// - TickError: NegativeSteps | GridError(GridError)
//// - tick(Grid, Ruleset) -> Result(Grid, TickError)
//// - tick_to(Grid, Ruleset, Int) -> Result(Grid, TickError)
//// Internal:
//// - tick_inner(Ruleset, Grid, GridState, Result(Grid, GridError)) -> Result(Grid, TickError)

// Local imports:
import grid.{type Grid, type GridError, type GridState} as gri
import neighbourhood as nei
import ruleset.{type Ruleset} as rus

// Public:

/// Errors for the tick module.
/// NegativeSteps means that the number of steps given to the tick_to function is negative which is not allowed as we lose information about the previous states as we tick.
/// GridError means that the tick_inner function encountered an error while ticking the Grid.
pub type TickError {
  NegativeSteps
  GridError(GridError)
}

/// This function takes a Grid and a Ruleset and returns the next Grid after the Ruleset is applied to it a single time.
/// If the Grid reaches the max_alive_cell_count during the tick, it will return an error.
pub fn tick(grid: Grid, ruleset: Ruleset) -> Result(Grid, TickError) {
  tick_inner(ruleset, grid, gri.get_transient_state_unsorted(grid), Ok(grid))
}

/// This function takes a Grid, a Ruleset and a number of times to apply the Ruleset to the Grid and returns the final Grid.
/// If the number of times is negative, it will return an error.
/// If the Grid reaches the max_alive_cell_count during the ticks, it will return an error.
pub fn tick_to(
  grid: Grid,
  ruleset: Ruleset,
  steps: Int,
) -> Result(Grid, TickError) {
  case steps {
    number if number < 0 -> Error(NegativeSteps)
    0 -> Ok(grid)
    number -> {
      case tick(grid, ruleset) {
        Ok(valid_next_grid) -> tick_to(valid_next_grid, ruleset, number - 1)
        error -> error
      }
    }
  }
}

// Private:

/// Inner function for ticking a Grid.
pub fn tick_inner(
  ruleset: Ruleset,
  original_grid: Grid,
  temp: GridState,
  next_grid: Result(Grid, GridError),
) -> Result(Grid, TickError) {
  case next_grid, temp {
    Ok(valid_next_grid), [] -> Ok(valid_next_grid)
    Ok(valid_next_grid), [head, ..tail] ->
      tick_inner(
        ruleset,
        original_grid,
        tail,
        gri.add_cell(
          valid_next_grid,
          rus.apply(
            ruleset,
            nei.get_neighbourhood(original_grid, head.location),
          ),
        ),
      )
    Error(error), _ -> Error(GridError(error))
  }
}
