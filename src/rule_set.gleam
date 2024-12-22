//// src/rule_set.gleam
//// 
//// Module: rule_set
//// API:
//// - Ruleset
//// Internal:
//// * None

// External imports
import gleam/set

// Local imports
import rule

// Public

/// RuleSet type definition
pub type RuleSet =
  set.Set(rule.Rule)
