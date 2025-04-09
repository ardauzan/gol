//// src/ruleset.gleam
////
//// Module: ruleset
////
//// In this module, Rule object and its functions are defined.
//// A Ruleset is a list of Rules.
//// The Rules are checked in the order they are in the list.
//// If a Rule returns None, the state does not change.
//// If a Rule returns a Cell, that Cell will replace the current Cell in the next state.
//// Rules might be overlapping, meaning that more than one Rule can apply to the same state.
//// If more than one Rule applies to the same state, the first one that returns a Cell will be used.
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
/// If a Rule returns None, the state does not change.
/// If a Rule returns a Cell, that Cell will replace the current Cell in the next state.
/// Rules might be overlapping, meaning that more than one Rule can apply to the same state.
/// If more than one Rule applies to the same state, the first one that returns a Cell will be used.
pub type Ruleset =
  List(Rule)

/// Applies a Ruleset to a Neighbourhood.
/// When a Rule matches the input state that Rule is applied, even if there are more rules that match later in the list.
pub fn apply(ruleset: Ruleset, neighbourhood: Neighbourhood) -> Cell {
  apply_inner(ruleset, neighbourhood, opt.None)
}

// Private:

/// Inner logic for applying a Ruleset to a Neighbourhood.
fn apply_inner(
  ruleset: Ruleset,
  neighbourhood: Neighbourhood,
  temp: Option(Cell),
) -> Cell {
  case ruleset, temp {
    _, opt.Some(next_state) -> next_state
    [], opt.None -> neighbourhood.center
    // no more rules so state does not change.
    [head, ..tail], opt.None ->
      apply_inner(tail, neighbourhood, head(neighbourhood))
  }
}
