//// src/lib.gleam
//// 
//// Module:lib
//// API:
//// - add_unique(List(value), value) -> List(value)
//// Internal:
//// - contains(List(value), value) -> Bool

// External imports
import gleam/list as lis

// Public

/// Add item to list if it doesn't already exist.
pub fn add_unique(list: List(value), item: value) -> List(value) {
  case contains(list, item) {
    True -> list
    False -> [item, ..list]
  }
}

// Private

/// List contains item.
fn contains(list: List(value), item: value) -> Bool {
  lis.contains(list, item)
}
