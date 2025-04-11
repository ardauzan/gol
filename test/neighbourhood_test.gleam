//// test/neighbourhood_test.gleam
////
//// Module: neighbourhood_test
////
//// Test module for neighbourhood.
////
//// API:
//// - main() -> Nil
//// - get_neighbourhood_test() -> Nil
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
