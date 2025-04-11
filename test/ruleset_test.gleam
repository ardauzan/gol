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

// Non-local imports:
import gleam/option.{type Option} as opt
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell.{type Cell} as cel
import location as loc
import neighbourhood.{type Neighbourhood} as nei
import ruleset as rus

// Public:

/// Sets up the testing environment.
pub fn main() -> Nil {
  gle.main()
}

/// Tests the apply function.
pub fn apply_test() -> Nil {
  let neighbourhood =
    nei.Neighbourhood(
      cel.Alive(loc.Location(0, 0)),
      cel.Dead(loc.Location(1, 0)),
      cel.Dead(loc.Location(2, 0)),
      cel.Dead(loc.Location(0, 1)),
      cel.Alive(loc.Location(1, 1)),
      cel.Dead(loc.Location(2, 1)),
      cel.Dead(loc.Location(0, 2)),
      cel.Dead(loc.Location(1, 2)),
      cel.Alive(loc.Location(2, 2)),
    )
  let top_right_rule = fn(neighbourhood: Neighbourhood) -> Option(Cell) {
    case cel.is_alive(neighbourhood.top_right) {
      True -> opt.Some(cel.toggle(neighbourhood.center))
      False -> opt.None
    }
  }
  [top_right_rule]
  |> rus.apply(neighbourhood)
  |> sho.equal(cel.Dead(loc.Location(1, 1)))

  [
    fn(neighbourhood: Neighbourhood) -> Option(Cell) {
      let center = neighbourhood.center
      case
        {
          cel.count(neighbourhood.bottom_left)
          + cel.count(neighbourhood.bottom_center)
          + cel.count(neighbourhood.bottom_right)
          + cel.count(neighbourhood.left)
          + cel.count(neighbourhood.right)
          + cel.count(neighbourhood.top_left)
          + cel.count(neighbourhood.top_center)
          + cel.count(neighbourhood.top_right)
        },
        cel.is_alive(center)
      {
        _, False -> opt.None
        2, True -> opt.Some(center)
        3, True -> opt.Some(center)
        _, True -> opt.None
      }
    },
    top_right_rule,
  ]
  |> rus.apply(neighbourhood)
  |> sho.equal(cel.Alive(loc.Location(1, 1)))
}
