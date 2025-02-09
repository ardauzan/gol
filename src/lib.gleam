//// src/lib.gleam
////
//// Module:lib
////
//// In this module, the utility functions are defined.
//// We separate them from the modules they are used in to be able to reuse them.
////
//// API:
//// - remove(List(value), value) -> List(value)
//// Internal:
//// * None

// External imports:
import gleam/list as lis

// Public:

/// Remove item from list.
pub fn remove(list: List(value), item_outer: value) -> List(value) {
  lis.filter(list, fn(item_inner: value) -> Bool { item_inner != item_outer })
}
