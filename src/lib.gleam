//// src/lib.gleam
////
//// Module: lib
////
//// In this module, all of the shared functions and types are defined.
////
//// API:
//// - remove(List(a), a) -> List(a)
//// Internal:
//// * None

// External imports:
import gleam/list as lis

// Public:

/// Remove all occurrences of an element from a list.
pub fn remove(list: List(a), outer: a) -> List(a) {
  lis.filter(list, fn(inner: a) -> Bool { outer != inner })
}
