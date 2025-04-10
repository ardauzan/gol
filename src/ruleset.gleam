//// src/ruleset.gleam
////
//// Module: ruleset
////
//// In this module, Ruleset object and its functions are defined.
//// A Ruleset is a list of Rules.
//// The Rules are checked in the order they are in the list.
//// If a Rule returns None, we apply the next Rule.
//// If a Rule returns a Some(Cell), that Cell will replace the center Cell after a tick.
//// Rules might be overlapping, meaning that more than one Rule might match the same Neighbourhood.
//// If more than one Rule matches to the same Neighbourhood, the first one in the Ruleset will be used.
////
//// API:
//// - Ruleset: List(Rule)
//// - apply(Ruleset, Neighbourhood) -> Cell
//// Internal:
//// - apply_inner(Ruleset, Neighbourhood, Option(Cell)) -> Cell

// Non-local imports:
import gleam/option.{type Option} as opt

// Local imports:
import cell.{type Cell}
import neighbourhood.{type Neighbourhood}
import rule.{type Rule}

// Public:

/// A Ruleset is a list of Rules.
/// The Rules are checked in the order they are in the list.
/// If a Rule returns None, we apply the next Rule.
/// If a Rule returns a Some(Cell), that Cell will replace the center Cell after a tick.
/// Rules might be overlapping, meaning that more than one Rule might match the same Neighbourhood.
/// If more than one Rule matches to the same Neighbourhood, the first one in the Ruleset will be used.
pub type Ruleset =
  List(Rule)

/// Applies a Ruleset to a Neighbourhood.
/// When a Rule matches the input, that Rule is applied and the result is returned, even if there are more rules that match later in the Ruleset.
pub fn apply(ruleset: Ruleset, neighbourhood: Neighbourhood) -> Cell {
  apply_inner(ruleset, neighbourhood, opt.None)
}

// Private:

/// Inner function for applying a Ruleset to a Neighbourhood.
fn apply_inner(
  ruleset: Ruleset,
  neighbourhood: Neighbourhood,
  temp: Option(Cell),
) -> Cell {
  case ruleset, temp {
    _, opt.Some(next_state) -> next_state
    [], opt.None -> neighbourhood.center
    [head, ..tail], opt.None ->
      apply_inner(tail, neighbourhood, head(neighbourhood))
  }
}
