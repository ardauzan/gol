# Game of Life (GOL)

*A simple implementation of Conway's Game of Life, written in Gleam.*

## Overview

This project is a personal exercise in learning the Gleam programming language by implementing the Game of Life from scratch, without third-party libraries. It is a learning tool and **not intended for production use**. The code is **licensed under MIT** and is available at [GitHub](https://github.com/ardauzan/gol). Contributions and usage are welcome, but please credit the project if you find it helpful. Don't forget to give it a star if you like it! :star:

## Modules

The project is divided into the following source modules:

- [cell_set](src/cell_set.gleam)
- [cell](src/cell.gleam)
- [gol (Main)](src/gol.gleam)
- [lib](src/lib.gleam)
- [location_set](src/location_set.gleam)
- [location](src/location.gleam)
- [neighbourhood_set](src/neighbourhood_set.gleam)
- [neighbourhood](src/neighbourhood.gleam)
- [rule_set](src/rule_set.gleam)
- [rule](src/rule.gleam)

And also the following test modules:

- [cell_test](test/cell_test.gleam)
- [gol_test](test/gol_test.gleam)
- [lib_test](test/lib_test.gleam)
- [location_set_test](test/location_set_test.gleam)
- [location_test](test/location_test.gleam)
- [neighbourhood_set_test](test/neighbourhood_set_test.gleam)
- [neighbourhood_test](test/neighbourhood_test.gleam)
- [rule_set_test](test/rule_set_test.gleam)
- [rule_test](test/rule_test.gleam)

## Todo

- [ ] Complete cell_set
- [ ] Complete cell
- [ ] Complete location_set
- [ ] Complete location
- [ ] Complete neighbourhood_set
- [ ] Complete neighbourhood
- [ ] Complete rule_set
- [ ] Complete rule
- [ ] Complete cell_set_test
- [ ] Complete cell_test
- [ ] Complete location_set_test
- [ ] Complete location_test
- [ ] Complete neighbourhood_set_test
- [ ] Complete neighbourhood_test
- [ ] Complete rule_set_test
- [ ] Complete rule_test
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
