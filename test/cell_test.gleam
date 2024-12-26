//// test/cell_test.gleam
//// 
//// Module: cell_test
//// API:
//// * None
//// Internal:
//// * None

// External imports
import gleeunit as gle
import gleeunit/should as sho

// Local imports
import cell as cel
import location as loc

// Public

/// Setup for testing:
pub fn main() -> Nil {
  gle.main()
}

/// Test the cell constructor.
pub fn new_test() -> Nil {
  let x = 16
  let y = -14
  let location = loc.new(x, y)
  let alive = False
  cel.new(location, alive)
  |> sho.equal(cel.Dead(#(16, -14)))
}

/// Test the is_alive function.
pub fn is_alive_test() -> Nil {
  let x = 33
  let y = -14
  let location = loc.new(x, y)
  let alive = True
  cel.new(location, alive)
  |> cel.is_alive
  |> sho.equal(True)
}

/// Test the is_dead function.
pub fn is_dead_test() -> Nil {
  let x = 10
  let y = -10
  let location = loc.new(x, y)
  let alive = False
  cel.new(location, alive)
  |> cel.is_dead
  |> sho.equal(True)
}

/// Test the toggle function.
pub fn toggle_test() -> Nil {
  let x = 10
  let y = -10
  let location = loc.new(x, y)
  let alive = True
  cel.new(location, alive)
  |> cel.toggle
  |> cel.is_dead
  |> sho.equal(True)
}

/// Test the get_location function.
pub fn get_location_test() -> Nil {
  let x = 8
  let y = 0
  let location = loc.new(x, y)
  let alive = True
  cel.new(location, alive)
  |> cel.get_location
  |> sho.equal(#(8, 0))
}
