# Game of Life (GOL)

*A simple implementation of Conway's Game of Life, written in Gleam.*

Donate:
[![Ethereum](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white)](copy("0x5dF4D4c4D4c4D4c4D4c4D4c4D4c4D4c4D4c4D4c4"))

## Overview

This project is a personal exercise in learning the Gleam programming language by implementing the Game of Life from scratch, without third-party libraries. It is a learning tool and ==not intended for production use==. The code is ==licensed under MIT== and is available at [GitHub](https://github.com/ardauzan/gol). Contributions and usage are welcome, but please credit the project if you find it helpful. Don't forget to give it a star if you like it! :star:

## Definitions

Cell
: A cell is either alive or dead and has an x and y position.

Grid
: A grid is a two-dimensional array of cells.

Neighbourhood
: A cell's neighbourhood is the cells that are directly adjacent to it.

## Todo

- [ ] Add tests

### Requirements

- [Gleam](https://gleam.run) – The Gleam programming language
- [Gleam Standard Library](https://hex.pm/packages/gleam_stdlib) – Gleam’s standard library
- [VSCode](https://code.visualstudio.com) – Recommended development environment with relevant extensions (see `.vscode/extensions.json`)

#### Setup

Install dependencies:

```bash
gleam install
```

##### Usage

Run the project:

```bash
gleam run
```

Run tests:

```bash
gleam test
```

###### License

See the [**License file**](LICENSE.txt). Licensed under the [**MIT License**](https://wikipedia.org/wiki/MIT_License).

**--** ***A. Uzan***
