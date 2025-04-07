//// src/gol.gleam
////
//// Module: gol (Main)
////
//// This is the main module of the project.
//// It contains the main function.
////
//// API:
//// - main() -> Nil
//// Internal:
//// * None

// Non-local imports:
import gleam/io

// Local imports:
import grid.{type Grid, type GridError, type GridState} as gri
import neighbourhood as nei
import ruleset.{type Ruleset} as rus

// Public:

/// Errors for the tick module.
pub type TickError {
  NegativeSteps
  GridError(GridError)
}

/// Tick function.
/// This function takes a grid and a ruleset and returns the next state of the grid after one tick.
pub fn tick(grid: Grid, ruleset: Ruleset) -> Result(Grid, TickError) {
  tick_inner(ruleset, grid, gri.get_transient_state_unsorted(grid), Ok(grid))
}

/// Tick to function.
/// It takes a grid, a ruleset and the number of steps, if the number is negative or 0 it returns the grid.
/// Normally the steps will not go to negative unless the function is called with a negative number;
/// In that case we return the grid as is, same as if the number was 0.
pub fn tick_to(
  grid: Grid,
  ruleset: Ruleset,
  steps: Int,
) -> Result(Grid, TickError) {
  case steps {
    number if number < 0 -> Error(NegativeSteps)
    0 -> Ok(grid)
    number -> {
      let next_grid: Result(Grid, TickError) = tick(grid, ruleset)
      case next_grid {
        Ok(valid_next_grid) -> tick_to(valid_next_grid, ruleset, number - 1)
        error -> error
      }
    }
  }
}

/// Entry point of the program.
pub fn main() -> Nil {
  io.println("Todo")
}

// Private:

/// Tick functions inner function.
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
