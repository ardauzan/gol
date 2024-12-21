// src/rule.gleam

// Local imports
import grid as g

// Public

// Rule type definition
// A rule is a function that takes a transient grid and returns a new transient grid that has the same cells only with changed states.
// Rules are meant to be solely based on the alive cell count in a cell's neighbourhood, depending on that, the cell will either be alive or dead after the tick.

pub type Rule =
  fn(g.Grid, fn(g.Grid, Int) -> g.Grid) -> g.Grid

pub fn new() -> Rule {
  todo
}
