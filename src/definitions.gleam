//// src/definitions.gleam
////
//// Module: definitions
////
//// In this module, some rules and some grid states are defined.
////
//// API:
//// * None
//// Internal:
//// * None

// External imports:
import gleam/option.{type Option} as opt

// Local imports:
import cell.{type Cell} as cel
import grid.{type GridState}
import location as loc
import neighbourhood.{type Neighbourhood} as nei
import ruleset.{type Ruleset}

//Classic Game of Life:

//Rules:

/// Classic birth rule.
pub fn classic_birth_rule(neighbourhood: Neighbourhood) -> Option(Cell) {
  case
    nei.get_center_state(neighbourhood),
    nei.get_alive_neighbour_count(neighbourhood)
  {
    True, _ -> opt.None
    False, 3 -> opt.Some(cel.toggle(neighbourhood.center))
    False, _ -> opt.None
  }
}

/// Classic survival rule.
pub fn classic_survival_rule(neighbourhood: Neighbourhood) -> Option(Cell) {
  case
    nei.get_center_state(neighbourhood),
    nei.get_alive_neighbour_count(neighbourhood)
  {
    False, _ -> opt.None
    True, 2 -> opt.None
    True, 3 -> opt.None
    True, _ -> opt.Some(cel.toggle(neighbourhood.center))
  }
}

// Rulesets:

/// Classic Game of Life ruleset.
pub const classic_ruleset: Ruleset = [classic_birth_rule, classic_survival_rule]

// Grid states:

pub const copperhead: GridState = [
  cel.Alive(loc.Location(0, 3)),
  cel.Alive(loc.Location(0, 4)),
  cel.Alive(loc.Location(1, 3)),
  cel.Alive(loc.Location(1, 4)),
  cel.Alive(loc.Location(3, 2)),
  cel.Alive(loc.Location(3, 3)),
  cel.Alive(loc.Location(3, 4)),
  cel.Alive(loc.Location(3, 5)),
  cel.Alive(loc.Location(4, 1)),
  cel.Alive(loc.Location(4, 2)),
  cel.Alive(loc.Location(4, 5)),
  cel.Alive(loc.Location(4, 6)),
  cel.Alive(loc.Location(5, 0)),
  cel.Alive(loc.Location(5, 7)),
  cel.Alive(loc.Location(7, 0)),
  cel.Alive(loc.Location(7, 7)),
  cel.Alive(loc.Location(8, 0)),
  cel.Alive(loc.Location(8, 2)),
  cel.Alive(loc.Location(8, 5)),
  cel.Alive(loc.Location(8, 7)),
  cel.Alive(loc.Location(9, 3)),
  cel.Alive(loc.Location(9, 4)),
  cel.Alive(loc.Location(10, 3)),
  cel.Alive(loc.Location(10, 4)),
  cel.Alive(loc.Location(11, 1)),
  cel.Alive(loc.Location(11, 2)),
  cel.Alive(loc.Location(11, 5)),
  cel.Alive(loc.Location(11, 6)),
]
