//// test/neighbourhood_test.gleam
////
//// Module: neighbourhood_test
////
//// Test module for neighbourhood.
////
//// API:
//// - main() -> Nil
//// - new_test() -> Nil
//// - get_center_state_test() -> Nil
//// - get_alive_neighbour_count_test() -> Nil
//// Internal:
//// * None

// External imports:
import gleeunit as gle
import gleeunit/should as sho

// Local imports:
import cell as cel
import grid as gri
import location as loc
import neighbourhood as nei

// Public:

/// Setup for testing.
pub fn main() -> Nil {
  gle.main()
  Nil
}

/// Test the neighbourhood constructor.
pub fn new_test() -> Nil {
  gri.new()
  |> gri.add(cel.new(loc.new(1, 1), True))
  |> sho.be_ok()
  |> nei.new(loc.new(0, 1))
  |> sho.equal(
    Ok(#(
      cel.Dead(#(-1, 0)),
      cel.Dead(#(-1, 1)),
      cel.Dead(#(-1, 2)),
      cel.Dead(#(0, 0)),
      cel.Dead(#(0, 1)),
      cel.Dead(#(0, 2)),
      cel.Dead(#(1, 0)),
      cel.Alive(#(1, 1)),
      cel.Dead(#(1, 2)),
    )),
  )
  Nil
}

/// Test the get_center_state function.
pub fn get_center_state_test() -> Nil {
  gri.new()
  |> gri.add(cel.new(loc.new(1, 1), True))
  |> sho.be_ok()
  |> nei.new(loc.new(1, 1))
  |> sho.be_ok()
  |> nei.get_center_state()
  |> sho.equal(True)
  gri.new()
  |> nei.new(loc.new(3, 4))
  |> sho.be_ok()
  |> nei.get_center_state()
  |> sho.equal(False)
  Nil
}

/// Test the get_alive_neighbour_count function.
pub fn get_alive_neighbour_count_test() -> Nil {
  gri.new()
  |> nei.new(loc.new(1, 1))
  |> sho.be_ok()
  |> nei.get_alive_neighbour_count()
  |> sho.equal(0)
  gri.new()
  |> gri.add(cel.new(loc.new(1, 1), True))
  |> sho.be_ok()
  |> nei.new(loc.new(0, 0))
  |> sho.be_ok()
  |> nei.get_alive_neighbour_count()
  |> sho.equal(1)
  Nil
}
