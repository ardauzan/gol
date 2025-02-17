//// test/grid_test.gleam
////
//// Module: grid_test
////
//// Test module for grid.
////
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - add_cell_test() -> Nil
//// - get_state_test() -> Nil
//// - get_neighbours_from_grid_test() -> Nil
//// - get_neighbours_from_state_test() -> Nil
//// - get_transient_state_test() -> Nil
//// - get_cell_from_grid_test() -> Nil
//// - get_cell_from_state_test() -> Nil
//// Internal:
//// * None

// External imports:
/// - get_neighbours_from_state_test() -> Nil
import gleam/option as opt
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell as cel
import grid as gri
import location as loc

// Public:

/// Setup for testing.
pub fn main() -> Nil {
  gle.main()
}

/// Test the new function.
pub fn new_test() -> Nil {
  gri.get_state(
    gri.new(
      opt.Some([cel.Alive(loc.Location(0, 0)), cel.Dead(loc.Location(0, 0))]),
    ),
  )
  |> sho.equal([cel.Alive(loc.Location(0, 0))])
}

/// Test the add_cell function.
pub fn add_cell_test() -> Nil {
  gri.new(opt.None)
  |> gri.add_cell(cel.Alive(loc.Location(0, 0)))
  |> gri.get_state()
  |> sho.equal([cel.Alive(loc.Location(0, 0))])
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]))
  |> gri.add_cell(cel.Dead(loc.Location(0, 0)))
  |> gri.get_state()
  |> sho.equal([])
}

/// Test the get_state function.
pub fn get_state_test() -> Nil {
  gri.new(opt.None)
  |> gri.get_state
  |> sho.equal([])
}

/// Test the get_neighbours_from_grid function.
pub fn get_neighbours_from_grid_test() -> Nil {
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]))
  |> gri.get_neighbours_from_grid(loc.Location(0, 0))
  |> sho.equal([
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  ])
}

/// Test the get_neighbours_from_state function.
pub fn get_neighbours_from_state_test() -> Nil {
  [cel.Alive(loc.Location(0, 0)), cel.Dead(loc.Location(0, 0))]
  |> gri.get_neighbours_from_state(loc.Location(0, 0))
  |> sho.equal([
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  ])
}

/// Test the get_transient_state function.
pub fn get_transient_state_test() -> Nil {
  gri.new(
    opt.Some([cel.Alive(loc.Location(0, 0)), cel.Alive(loc.Location(1, 1))]),
  )
  |> gri.get_transient_state()
  |> sho.equal([
    cel.Alive(loc.Location(0, 0)),
    cel.Alive(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
    cel.Dead(loc.Location(0, 2)),
    cel.Dead(loc.Location(1, 2)),
    cel.Dead(loc.Location(2, 2)),
    cel.Dead(loc.Location(2, 1)),
    cel.Dead(loc.Location(2, 0)),
  ])
}

/// Test the get_cell_from_grid function.
pub fn get_cell_from_grid_test() -> Nil {
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]))
  |> gri.get_cell_from_grid(loc.Location(0, 0))
  |> sho.equal(cel.Alive(loc.Location(0, 0)))
  gri.new(opt.None)
  |> gri.get_cell_from_grid(loc.Location(0, 0))
  |> sho.equal(cel.Dead(loc.Location(0, 0)))
}

/// Test the get_cell_from_state function.
pub fn get_cell_from_state_test() -> Nil {
  [cel.Alive(loc.Location(0, 0)), cel.Dead(loc.Location(0, 0))]
  |> gri.get_cell_from_state(loc.Location(0, 0))
  |> sho.equal(cel.Alive(loc.Location(0, 0)))
  []
  |> gri.get_cell_from_state(loc.Location(0, 0))
  |> sho.equal(cel.Dead(loc.Location(0, 0)))
}
