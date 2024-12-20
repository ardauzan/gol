pub type Cell {
  Alive(x: Int, y: Int)
  Dead(x: Int, y: Int)
}

pub fn is_alive(cell: Cell) -> Bool {
  case cell {
    Alive(_, _) -> True
    Dead(_, _) -> False
  }
}

pub fn is_dead(cell: Cell) -> Bool {
  !is_alive(cell)
}

pub fn get_x(cell: Cell) -> Int {
  case cell {
    Alive(x, _) -> x
    Dead(x, _) -> x
  }
}

pub fn get_y(cell: Cell) -> Int {
  case cell {
    Alive(_, y) -> y
    Dead(_, y) -> y
  }
}
