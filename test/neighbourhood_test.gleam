//// test/neighbourhood_test.gleam
////
//// Module: neighbourhood_test
////
//// Test module for neighbourhood.
////
//// API:
//// - main() -> Nil
//// - get_neighbourhood_test() -> Nil
//// - get_center_state_test() -> Nil
//// - get_alive_neighbour_count_test() -> Nil
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
import neighbourhood as nei

// Public:

/// Sets up the testing environment.
pub fn main() -> Nil {
  gle.main()
}

/// Tests the get_neighbourhood function.
pub fn get_neighbourhood_test() -> Nil {
  gri.new(
    opt.Some([
      cel.Alive(loc.Location(0, 0)),
      cel.Alive(loc.Location(-1, -1)),
      cel.Alive(loc.Location(1, 1)),
      cel.Alive(loc.Location(-1, 0)),
    ]),
    opt.None,
  )
  |> sho.be_ok()
  |> nei.get_neighbourhood(loc.Location(0, 0))
  |> sho.equal(nei.Neighbourhood(
    cel.Alive(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
    cel.Alive(loc.Location(-1, 0)),
    cel.Alive(loc.Location(0, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Alive(loc.Location(1, 1)),
  ))
}

/// Tests the get_center_state function.
pub fn get_center_state_test() -> Nil {
  nei.Neighbourhood(
    cel.Alive(loc.Location(-2, 14)),
    cel.Dead(loc.Location(-1, 14)),
    cel.Alive(loc.Location(0, 14)),
    cel.Dead(loc.Location(-2, 15)),
    cel.Alive(loc.Location(-1, 15)),
    cel.Dead(loc.Location(0, 15)),
    cel.Alive(loc.Location(-2, 16)),
    cel.Dead(loc.Location(-1, 16)),
    cel.Alive(loc.Location(0, 16)),
  )
  |> nei.get_center_state
  |> sho.be_true

  nei.Neighbourhood(
    cel.Dead(loc.Location(2, 7)),
    cel.Alive(loc.Location(3, 7)),
    cel.Dead(loc.Location(4, 7)),
    cel.Alive(loc.Location(2, 8)),
    cel.Dead(loc.Location(3, 8)),
    cel.Alive(loc.Location(4, 8)),
    cel.Dead(loc.Location(2, 9)),
    cel.Alive(loc.Location(3, 9)),
    cel.Dead(loc.Location(4, 9)),
  )
  |> nei.get_center_state
  |> sho.be_false
}

/// Tests the get_alive_neighbour_count function.
pub fn get_alive_neighbour_count_test() -> Nil {
  nei.Neighbourhood(
    cel.Alive(loc.Location(-2, 14)),
    cel.Dead(loc.Location(-1, 14)),
    cel.Alive(loc.Location(0, 14)),
    cel.Dead(loc.Location(-2, 15)),
    cel.Alive(loc.Location(-1, 15)),
    cel.Dead(loc.Location(0, 15)),
    cel.Alive(loc.Location(-2, 16)),
    cel.Dead(loc.Location(-1, 16)),
    cel.Alive(loc.Location(0, 16)),
  )
  |> nei.get_alive_neighbour_count
  |> sho.equal(4)

  nei.Neighbourhood(
    cel.Dead(loc.Location(2, 7)),
    cel.Alive(loc.Location(3, 7)),
    cel.Dead(loc.Location(4, 7)),
    cel.Alive(loc.Location(2, 8)),
    cel.Dead(loc.Location(3, 8)),
    cel.Alive(loc.Location(4, 8)),
    cel.Dead(loc.Location(2, 9)),
    cel.Alive(loc.Location(3, 9)),
    cel.Alive(loc.Location(4, 9)),
  )
  |> nei.get_alive_neighbour_count
  |> sho.equal(5)
}
