//// src/definitions.gleam
////
//// Module: definitions
////
//// In this module, the classic game of life rules are defined.
////
//// API:
//// - underpopulation_rule() -> Rule
//// - overpopulation_rule() -> Rule
//// - survival_rule() -> Rule
//// - reproduction_rule() -> Rule
//// Internal:
//// * None

// Local imports:
import cell as cel
import neighbourhood as nei
import rule as rul

// Public:

/// Underpopulation rule.
pub fn underpopulation_rule() -> rul.Rule {
  rul.add_logic(rul.new(), underpopulation_inner())
}

// Private:

fn underpopulation_inner() -> rul.Rule {
  fn(neighbourhood: nei.Neighbourhood) -> cel.Cell {
    let alive_neighbour_count = nei.alive_neighbour_count(neighbourhood)
    let #(_cell1, _cell2, _cell3, _cell4, cell5, _cell6, _cell7, _cell8, _cell9) =
      neighbourhood
    case cel.is_alive(cell5), alive_neighbour_count {
      True, value if value < 2 -> cel.toggle(cell5)
      _value, _value -> cell5
    }
  }
}
