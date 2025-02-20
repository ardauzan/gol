//// src/gol.gleam
////
//// Module: gol (Main)
////
//// Here's the main module for gol.
////
//// API:
//// - tick(Grid, Ruleset) -> Grid
//// - tick_to(Grid, Ruleset, Int) -> Grid
//// - main() -> Nil
//// Internal:
//// - tick_inner(Ruleset, Grid, GridState, Grid) -> Grid

// External imports:
import gleam/io

// Local imports:
import grid.{type Grid, type GridState} as gri
import neighbourhood as nei
import ruleset.{type Ruleset} as rus

// Public:

/// Tick function.
/// This function takes a grid and a ruleset and returns the next state of the grid after one tick.
pub fn tick(grid: Grid, ruleset: Ruleset) -> Grid {
  tick_inner(ruleset, grid, gri.get_transient_state(grid), grid)
}

/// Tick to function.
/// This function is recursive.
/// It takes a grid, a ruleset and the number of steps, if the number is negative or 0 it returns the grid.
/// Normally the steps will not go to negative unless the function is called with a negative number;
/// In that case we return the grid as is, same as if the number was 0.
pub fn tick_to(grid: Grid, ruleset: Ruleset, steps: Int) -> Grid {
  case steps {
    s if s > 0 -> tick_to(tick(grid, ruleset), ruleset, s - 1)
    _ -> grid
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
  next_grid: Grid,
) -> Grid {
  case temp {
    [] -> next_grid
    [head, ..tail] ->
      tick_inner(
        ruleset,
        original_grid,
        tail,
        gri.add_cell(
          next_grid,
          rus.apply(
            ruleset,
            nei.get_neighbourhood_from_grid(original_grid, head.location),
          ),
        ),
      )
  }
}
