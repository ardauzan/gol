//// src/gol.gleam
////
//// Module: gol (Main)
////
//// Here's the main module for gol.
////
//// API:
//// - main() -> Nil
//// - GOLError
//// - tick(Grid, Ruleset, Int) -> Grid
//// Internal:
//// * None

// External imports:
import gleam/io

// Local imports:
import grid as gri

// Public

/// Entry point of the program.
pub fn main() -> Nil {
  io.println("Todo")
  Nil
}

/// GOLError type definition.
/// A gol error is an error that occurs when any of the functions exported by this module gets called with invalid arguments.
pub type GOLError {
  TODO
}

/// Tick the grid.
/// This function takes a grid, the ruleset to apply to the grid and the number of times to tick the grid then returns the grid that results.
pub fn tick(grid: gri.Grid, ruleset, count: Int) -> gri.Grid {
  todo
}
