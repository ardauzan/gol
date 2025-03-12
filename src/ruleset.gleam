//// src/ruleset.gleam
////
//// Module: ruleset
////
//// In this module, the Ruleset type and its functions are defined.
//// This turned out to be quite complex, for me at least.
//// Rules are applied in order and the first valid result is returned.
//// None means that the cell should not change state.
////
//// API:
//// - Ruleset
//// - apply(Ruleset, Neighbourhood) -> Cell
//// Internal:
//// - apply_inner(?) -> Cell

// External imports:
import gleam/option.{type Option} as opt

// Local imports:
import cell.{type Cell}
import neighbourhood.{type Neighbourhood}
import rule.{type Rule}

// Public:

/// The Ruleset type alias.
/// A Ruleset is a list of Rules.
pub type Ruleset =
  List(Rule)

/// Apply a Ruleset to a Neighbourhood.
/// When a rule matches the input state that rule is applied, even if there are more rules that match later in the list.
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
