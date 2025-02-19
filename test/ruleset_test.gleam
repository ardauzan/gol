//// test/ruleset_test.gleam
////
//// Module: ruleset_test
////
//// Test module for ruleset.
////
//// API:
//// - main() -> Nil
//// - apply_test() -> Nil
//// Internal:
//// * None

// External imports:
import gleam/option.{type Option} as opt
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell.{type Cell} as cel
import location as loc
import neighbourhood.{type Neighbourhood} as nei
import ruleset as rus

// Public:

/// Setup for testing.
pub fn main() -> Nil {
  gle.main()
}

/// Test apply.
pub fn apply_test() -> Nil {
  let top_left_rule = fn(neighbourhood: Neighbourhood) -> Option(Cell) {
    case cel.is_alive(neighbourhood.top_left) {
      True -> opt.Some(cel.Alive(neighbourhood.center.location))
      False -> opt.None
    }
  }
  let right_rule = fn(neighbourhood: Neighbourhood) -> Option(Cell) {
    case cel.is_alive(neighbourhood.right) {
      True -> opt.Some(cel.Alive(neighbourhood.center.location))
      False -> opt.None
    }
  }
  [top_left_rule, right_rule]
  |> rus.apply(nei.Neighbourhood(
    cel.Alive(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(0, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  ))
  |> sho.equal(cel.Alive(loc.Location(0, 0)))
  [top_left_rule, right_rule]
  |> rus.apply(nei.Neighbourhood(
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(0, 0)),
    cel.Alive(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  ))
  |> sho.equal(cel.Alive(loc.Location(0, 0)))
}
