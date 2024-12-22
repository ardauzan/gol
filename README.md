# Game of Life (GOL)

*A simple implementation of Conway's Game of Life, written in Gleam.*

## Overview

This project is a personal exercise in learning the Gleam programming language by implementing the Game of Life from scratch, without third-party libraries. It is a learning tool and **not intended for production use**. The code is **licensed under MIT** and is available at [GitHub](https://github.com/ardauzan/gol). Contributions and usage are welcome, but please credit the project if you find it helpful. Don't forget to give it a star if you like it! :star:

## Modules

The project is divided into the following source modules:

- [cell](src/cell.gleam)
- [gol (Main)](src/gol.gleam)
- [grid](src/grid.gleam)
- [lib](src/lib.gleam)
- [location](src/location.gleam)
- [neighbourhood](src/neighbourhood.gleam)
- [neighbourhoods](src/neighbourhoods.gleam)
- [rule](src/rule.gleam)
- [ruleset](src/ruleset.gleam)

And also the following test modules:

- [cell_test](test/cell_test.gleam)
- [gol_test](test/gol_test.gleam)
- [grid_test](test/grid_test.gleam)
- [lib_test](test/lib_test.gleam)
- [location_test](test/location_test.gleam)
- [neighbourhood_test](test/neighbourhood_test.gleam)
- [neighbourhoods_test](test/neighbourhoods_test.gleam)
- [ruletest](test/rule_test.gleam)
- [ruleset_test](test/ruleset_test.gleam)

## Todo

Complete the source modules:

- [ ] Complete cell
- [ ] Complete grid
- [ ] Complete location
- [ ] Complete neighbourhood
- [ ] Complete neighbourhoods
- [ ] Complete rule
- [ ] Complete ruleset

Complete the test modules:

- [ ] Complete cell_test
- [ ] Complete grid_test
- [ ] Complete location_test
- [ ] Complete neighbourhood_test
- [ ] Complete neighbourhoods_test
- [ ] Complete rule_test
- [ ] Complete ruleset_test

Complete the everthing:

- [ ] Complete the project (GOL)

### Requirements

1) [Gleam](https://gleam.run) – The Gleam programming language
2) [Gleam Standard Library](https://hex.pm/packages/gleam_stdlib) – Gleam’s standard library
3) [VSCode](https://code.visualstudio.com) – Recommended development environment with relevant extensions (see `.vscode/extensions.json`)

### Setup

Install dependencies:

```bash
gleam install
```

### Usage

Run the project:

```bash
gleam run
```

Run tests:

```bash
gleam test
```

#### License

See the [**License file**](LICENSE.txt). Licensed under the [**MIT License**](https://wikipedia.org/wiki/MIT_License).

**--** ***A. Uzan***
