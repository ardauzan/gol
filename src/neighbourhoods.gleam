//// src/neighbourhoods.gleam
//// 
//// Module: neighbourhoods
//// API:
//// - Neighbourhoods
//// Internal:
//// * None

// Local imports
import neighbourhood as nei

// Public

/// Neighbourhoods type definition:
/// Neighbourhoods type is represented by a list of neighbourhoods.
/// It serves usefull to separate it from the singular neighbourhood as their purpose for existence is different, that is why this is here, in a different source file.
pub type Neighbourhoods =
  List(nei.Neighbourhood)
