//// src/gol.gleam
////
//// Module: gol (Main)
////
//// Here's the main module for gol.
////
//// API:
//// - main() -> Nil
//// Internal:
//// * None

// External imports:
import gleam/io

// Local imports:
import grid.{type Grid}
import ruleset.{type Ruleset}

// Public

/// GOLERROR type definition.
pub type GOLERROR {
  NegativeStepsError
}

/// Tick function.
pub fn tick(grid: Grid, ruleset: Ruleset) -> Grid {
  todo
}

/// Tick to function.
pub fn tick_to(
  grid: Grid,
  ruleset: Ruleset,
  steps: Int,
) -> Result(Grid, GOLERROR) {
  case steps {
    s if s > 0 -> tick_to(tick(grid, ruleset), ruleset, s - 1)
    0 -> Ok(grid)
    _ -> Error(NegativeStepsError)
  }
}

/// Entry point of the program.
pub fn main() -> Nil {
  io.println("Todo")
}
