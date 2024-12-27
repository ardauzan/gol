//// src/rule.gleam
////
//// Module: rule
////
//// In this module, the Rule type and its functions are defined.
////
//// API:
//// - Rule
//// - new() -> Rule
//// - add_case(Rule, Neighbourhood, Cell) -> Rule
//// - apply(Rule, Neighbourhood) -> Cell
//// Internal:
//// * None

// Local imports:
import cell as cel
import neighbourhood as nei

// IMPORTANT NOTE: In the traditional game of life, the next state is only determined by its current state and it's alive neighbour count. We instead determine the next state based on the current state and it's neighbourhood (exact equality so multiple versions of the neighbourhood can be differentiated even if they share the alive count).

// Public:

/// Rule type definition.
/// A rule is a function that takes a cell with it's neighbourhood and returns the next state of the cell after a tick.
pub type Rule =
  fn(nei.Neighbourhood) -> cel.Cell

/// Rule constructor.
pub fn new() -> Rule {
  fn(neighbourhood: nei.Neighbourhood) -> cel.Cell {
    case neighbourhood {
      #(_cell1, _cell2, _cell3, _cell4, cell5, _cell6, _cell7, _cell8, _cell9) ->
        cell5
    }
  }
}

/// Add case to rule.
pub fn add_case(
  rule: Rule,
  neighbourhood_outer: nei.Neighbourhood,
  next_state: cel.Cell,
) -> Rule {
  fn(neighbourhood_inner: nei.Neighbourhood) -> cel.Cell {
    case neighbourhood_inner {
      any if any == neighbourhood_outer -> next_state
      any -> rule(any)
    }
  }
}

// Apply rule to cell and it's neighbourhood.
pub fn apply(rule: Rule, neighbourhood: nei.Neighbourhood) -> cel.Cell {
  rule(neighbourhood)
}
