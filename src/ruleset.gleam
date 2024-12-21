// src/ruleset.gleam

import gleam/set as s

import rule as r

pub type Ruleset =
  s.Set(r.Rule)
