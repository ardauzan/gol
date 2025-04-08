//// test/grid_test.gleam
////
//// Module: grid_test
////
//// Test module for grid.
////
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - get_state_test() -> Nil
//// - get_max_alive_cell_count_test() -> Nil
//// - get_cell_test() -> Nil
//// - get_neighbours_test() -> Nil
//// - get_transient_state_unsorted_test() -> Nil
//// - get_transient_state_sorted_test() -> Nil
//// - add_cell_test() -> Nil
//// Internal:
//// * None

// Non-local imports:
import gleam/option as opt
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell as cel
import grid as gri
import location as loc

// Public:

/// Sets up the testing environment.
pub fn main() -> Nil {
  gle.main()
}

/// Tests the new function.
pub fn new_test() -> Nil {
  gri.new(opt.None, opt.None)
  |> sho.be_ok()
  gri.new(opt.Some([]), opt.None)
  |> sho.be_ok()
  gri.new(opt.None, opt.Some(0))
  |> sho.be_ok()
  gri.new(opt.Some([]), opt.Some(-1))
  |> sho.be_ok()
  gri.new(opt.Some([]), opt.Some(-2))
  |> sho.be_error()
  gri.new(
    opt.Some([cel.Alive(loc.Location(0, 0)), cel.Alive(loc.Location(0, 1))]),
    opt.Some(1),
  )
  |> sho.be_error()
  Nil
}

/// Tests the get_state function.
pub fn get_state_test() -> Nil {
  gri.new(opt.None, opt.None)
  |> sho.be_ok()
  |> gri.get_state()
  |> sho.equal([])
  gri.new(
    opt.Some([
      cel.Alive(loc.Location(0, 0)),
      cel.Dead(loc.Location(0, 1)),
      cel.Alive(loc.Location(0, 0)),
      cel.Alive(loc.Location(0, 1)),
      cel.Alive(loc.Location(2, 2)),
    ]),
    opt.None,
  )
  |> sho.be_ok()
  |> gri.get_state()
  |> sho.equal([
    cel.Alive(loc.Location(0, 0)),
    cel.Alive(loc.Location(0, 1)),
    cel.Alive(loc.Location(2, 2)),
  ])
}

/// Tests the get_max_alive_cell_count function.
pub fn get_max_alive_cell_count_test() -> Nil {
  gri.new(opt.None, opt.None)
  |> sho.be_ok()
  |> gri.get_max_alive_cell_count()
  |> sho.equal(gri.default_max_alive_cell_count)
  gri.new(opt.None, opt.Some(250))
  |> sho.be_ok()
  |> gri.get_max_alive_cell_count()
  |> sho.equal(250)
}

/// Tests the get_cell function.
pub fn get_cell_test() -> Nil {
  gri.new(opt.None, opt.None)
  |> sho.be_ok()
  |> gri.get_cell(loc.Location(0, 0))
  |> sho.equal(cel.Dead(loc.Location(0, 0)))
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]), opt.None)
  |> sho.be_ok()
  |> gri.get_cell(loc.Location(0, 0))
  |> sho.equal(cel.Alive(loc.Location(0, 0)))
}

/// Tests the get_neighbours function.
pub fn get_neighbours_test() -> Nil {
  gri.new(
    opt.Some([
      cel.Alive(loc.Location(0, 0)),
      cel.Alive(loc.Location(1, 1)),
      cel.Alive(loc.Location(2, 2)),
      cel.Alive(loc.Location(3, 3)),
      cel.Alive(loc.Location(-1, -1)),
    ]),
    opt.None,
  )
  |> sho.be_ok()
  |> gri.get_neighbours(loc.Location(0, 0))
  |> sho.equal([
    cel.Alive(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Alive(loc.Location(1, 1)),
  ])
}

/// Tests the get_transient_state_unsorted function.
pub fn get_transient_state_unsorted_test() -> Nil {
  gri.new(
    opt.Some([
      cel.Alive(loc.Location(0, 0)),
      cel.Alive(loc.Location(1, 1)),
      cel.Alive(loc.Location(2, 2)),
      cel.Alive(loc.Location(3, 3)),
      cel.Alive(loc.Location(-1, -1)),
    ]),
    opt.None,
  )
  |> sho.be_ok()
  |> gri.get_transient_state_unsorted()
  |> sho.equal([
    cel.Alive(loc.Location(-1, -1)),
    cel.Alive(loc.Location(0, 0)),
    cel.Alive(loc.Location(1, 1)),
    cel.Alive(loc.Location(2, 2)),
    cel.Alive(loc.Location(3, 3)),
    cel.Dead(loc.Location(-2, -2)),
    cel.Dead(loc.Location(-1, -2)),
    cel.Dead(loc.Location(0, -2)),
    cel.Dead(loc.Location(-2, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(-2, 0)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(1, -1)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(2, 0)),
    cel.Dead(loc.Location(2, 1)),
    cel.Dead(loc.Location(0, 2)),
    cel.Dead(loc.Location(1, 2)),
    cel.Dead(loc.Location(3, 1)),
    cel.Dead(loc.Location(3, 2)),
    cel.Dead(loc.Location(1, 3)),
    cel.Dead(loc.Location(2, 3)),
    cel.Dead(loc.Location(4, 2)),
    cel.Dead(loc.Location(4, 3)),
    cel.Dead(loc.Location(2, 4)),
    cel.Dead(loc.Location(3, 4)),
    cel.Dead(loc.Location(4, 4)),
  ])
}

/// Tests the get_transient_state_sorted function.
pub fn get_transient_state_sorted_test() -> Nil {
  gri.new(
    opt.Some([
      cel.Alive(loc.Location(0, 0)),
      cel.Alive(loc.Location(1, 1)),
      cel.Alive(loc.Location(2, 2)),
      cel.Alive(loc.Location(3, 3)),
      cel.Alive(loc.Location(-1, -1)),
    ]),
    opt.None,
  )
  |> sho.be_ok()
  |> gri.get_transient_state_sorted()
  |> sho.equal([
    cel.Alive(loc.Location(-1, -1)),
    cel.Alive(loc.Location(0, 0)),
    cel.Alive(loc.Location(1, 1)),
    cel.Alive(loc.Location(2, 2)),
    cel.Alive(loc.Location(3, 3)),
    cel.Dead(loc.Location(-2, -2)),
    cel.Dead(loc.Location(-1, -2)),
    cel.Dead(loc.Location(0, -2)),
    cel.Dead(loc.Location(-2, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
    cel.Dead(loc.Location(-2, 0)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(2, 0)),
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(2, 1)),
    cel.Dead(loc.Location(3, 1)),
    cel.Dead(loc.Location(0, 2)),
    cel.Dead(loc.Location(1, 2)),
    cel.Dead(loc.Location(3, 2)),
    cel.Dead(loc.Location(4, 2)),
    cel.Dead(loc.Location(1, 3)),
    cel.Dead(loc.Location(2, 3)),
    cel.Dead(loc.Location(4, 3)),
    cel.Dead(loc.Location(2, 4)),
    cel.Dead(loc.Location(3, 4)),
    cel.Dead(loc.Location(4, 4)),
  ])
}

/// Tests the add_cell function.
pub fn add_cell_test() -> Nil {
  gri.new(opt.None, opt.None)
  |> sho.be_ok()
  |> gri.add_cell(cel.Alive(loc.Location(0, 0)))
  |> sho.be_ok()
  |> gri.get_state()
  |> sho.equal([cel.Alive(loc.Location(0, 0))])
  gri.new(opt.None, opt.None)
  |> sho.be_ok()
  |> gri.add_cell(cel.Dead(loc.Location(0, 0)))
  |> sho.be_ok()
  |> gri.get_state()
  |> sho.equal([])
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]), opt.None)
  |> sho.be_ok()
  |> gri.add_cell(cel.Dead(loc.Location(0, 0)))
  |> sho.be_ok()
  |> gri.get_state()
  |> sho.equal([])
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]), opt.Some(1))
  |> sho.be_ok()
  |> gri.add_cell(cel.Alive(loc.Location(0, 0)))
  |> sho.be_ok()
  |> gri.get_state()
  |> sho.equal([cel.Alive(loc.Location(0, 0))])
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]), opt.Some(1))
  |> sho.be_ok()
  |> gri.add_cell(cel.Alive(loc.Location(0, 0)))
  |> sho.be_ok()
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]), opt.Some(1))
  |> sho.be_ok()
  |> gri.add_cell(cel.Alive(loc.Location(0, 1)))
  |> sho.be_error()
  Nil
}
