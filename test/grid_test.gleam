//// test/grid_test.gleam
//// 
//// Module: grid_test
//// API:
//// * None
//// Internal:
//// * None

// External imports
import gleeunit as gle
import gleeunit/should as sho

// Local imports
import cell as cel
import grid as gri
import location as loc

// Public

/// Setup for testing:
pub fn main() -> Nil {
  gle.main()
}

/// Test the grid constructor.
pub fn new_test() -> Nil {
  gri.new()
  |> sho.equal([])
}

/// Test the make_proper function.
pub fn make_proper_test() -> Nil {
  gri.make_proper(gri.new())
  |> sho.equal([])
  gri.make_proper(gri.add(gri.new(), cel.new(loc.new(0, 0), True)))
  |> sho.equal([cel.Alive(loc.new(0, 0))])
}
