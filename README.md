# Game of Life (GOL) :space_invader:

*A simple implementation of Conway's Game of Life, written in Gleam.*

## Overview

This project is a personal exercise in learning the Gleam programming language by implementing the Game of Life from scratch, without third-party libraries. It is a learning tool and **not intended for production use**. The code is **licensed under MIT** and is available at [GitHub](https://github.com/ardauzan/gol). Contributions and usage are welcome, but please credit the project if you find it helpful. Don't forget to give it a star if you like it! :star:

## Modules

:pushpin: The project is divided into the following source modules:

- [cell](src/cell.gleam)
- [definitions](src/definitions.gleam)
- [gol (Main)](src/gol.gleam)
- [grid](src/grid.gleam)
- [lib](src/lib.gleam)
- [location](src/location.gleam)
- [neighbourhood](src/neighbourhood.gleam)
- [neighbourhoods](src/neighbourhoods.gleam)
- [rule](src/rule.gleam)
- [ruleset](src/ruleset.gleam)

:pushpin: And also the following test modules:

- [cell_test](test/cell_test.gleam)
- [definitions_test](test/definitions_test.gleam)
- [gol_test](test/gol_test.gleam)
- [grid_test](test/grid_test.gleam)
- [lib_test](test/lib_test.gleam)
- [location_test](test/location_test.gleam)
- [neighbourhood_test](test/neighbourhood_test.gleam)
- [neighbourhoods_test](test/neighbourhoods_test.gleam)
- [rule_test](test/rule_test.gleam)
- [ruleset_test](test/ruleset_test.gleam)

### Todo

:pushpin: Complete the source modules:

- [X] Complete cell
- [ ] Complete definitions
- [ ] Complete gol (Main)
- [X] Complete grid
- [X] Complete lib
- [X] Complete location
- [X] Complete neighbourhood
- [ ] Complete neighbourhoods
- [ ] Complete rule
- [ ] Complete ruleset

:pushpin: Complete the test modules:

- [X] Complete cell_test
- [ ] Complete definitions_test
- [ ] Complete gol_test
- [X] Complete grid_test
- [X] Complete lib_test
- [X] Complete location_test
- [X] Complete neighbourhood_test
- [ ] Complete neighbourhoods_test
- [ ] Complete rule_test
- [ ] Complete ruleset_test

:pushpin: Complete the documentation:

- [X] Complete the README

:pushpin: Complete the project:

- [ ] Complete the project (GOL)

#### Requirements

1) [Gleam](https://gleam.run) – The Gleam programming language, version 1.8.0 or later
2) [VSCode Editor](https://code.visualstudio.com) – Recommended development environment with relevant extensions (see [`.vscode/extensions.json`](.vscode/extensions.json))

#### Usage

:pushpin: Run the project:

```bash
gleam run
```

:pushpin: Run tests:

```bash
gleam test
```

##### Notes

- I'm on Linux and I found that the easiest way to install and keep Gleam updated is via [Homebrew](https://brew.sh). It also works for Mac too, if you are on Windows the official docs [here](https://gleam.run/getting-started/installing) say that you should use [Scoop](https://scoop.sh).
- The project will include a web application in the future, which will be accessible at [https://ardauzan.github.io/gol](https://ardauzan.github.io/gol).
- As I learn more about Gleam, I'll consider using different types, right now I'm using either `List` or `Tuple` for item collections which might not be the best choice.

##### License

See the [**License file**](LICENSE.txt). Licensed under the [**MIT License**](https://wikipedia.org/wiki/MIT_License).

###### Have a nice day! :smile:

**--** ***A. Uzan***
