//// test/neighbourhood_test.gleam
////
//// Module: neighbourhood_test
////
//// Test module for neighbourhood.
////
//// API:
//// - main() -> Nil
//// - get_neighbourhood_from_grid_test() -> Nil
//// - get_neighbourhood_from_state_test() -> Nil
//// - get_center_state_test() -> Nil
//// - get_alive_neighbour_count_test() -> Nil
//// Internal:
//// * None

// External imports:
import gleam/option as opt
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
}

/// Test the get_neighbourhood_from_grid function.
pub fn get_neighbourhood_from_grid_test() -> Nil {
  gri.new(opt.Some([cel.Alive(loc.Location(0, 0))]))
  |> nei.get_neighbourhood_from_grid(loc.Location(0, 0))
  |> sho.equal(nei.Neighbourhood(
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Alive(loc.Location(0, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  ))
}

/// Test the get_neighbourhood_from_state function.
pub fn get_neighbourhood_from_state_test() -> Nil {
  [cel.Alive(loc.Location(0, 0)), cel.Dead(loc.Location(0, 0))]
  |> nei.get_neighbourhood_from_state(loc.Location(0, 0))
  |> sho.equal(nei.Neighbourhood(
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Alive(loc.Location(0, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  ))
}

/// Test the get_center_state function.
pub fn get_center_state_test() -> Nil {
  nei.Neighbourhood(
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Alive(loc.Location(0, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  )
  |> nei.get_center_state()
  |> sho.be_true()
}

/// Test the get_alive_neighbour_count function.
pub fn get_alive_neighbour_count_test() -> Nil {
  nei.Neighbourhood(
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Alive(loc.Location(0, 0)),
    cel.Dead(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Dead(loc.Location(1, -1)),
  )
  |> nei.get_alive_neighbour_count()
  |> sho.equal(0)
  nei.Neighbourhood(
    cel.Dead(loc.Location(-1, 1)),
    cel.Dead(loc.Location(0, 1)),
    cel.Dead(loc.Location(1, 1)),
    cel.Dead(loc.Location(-1, 0)),
    cel.Alive(loc.Location(0, 0)),
    cel.Alive(loc.Location(1, 0)),
    cel.Dead(loc.Location(-1, -1)),
    cel.Dead(loc.Location(0, -1)),
    cel.Alive(loc.Location(1, -1)),
  )
  |> nei.get_alive_neighbour_count()
  |> sho.equal(2)
}
