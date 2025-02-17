# Game of Life (GOL) :space_invader:

*A simple implementation of Conway's Game of Life, written in Gleam.*

## Overview

This project is a personal exercise in learning the Gleam programming language by implementing the Game of Life from scratch, using as little third-party libraries as possible. This is a learning tool and **not intended for production use**. The code is **licensed under MIT License** and is available at [GitHub](https://github.com/ardauzan/gol). Contributions and usage are welcome, but please credit the project if you find it helpful. Don't forget to give it a star if you like it! :star:

## Modules

:pushpin: The project is divided into the following source modules:

- [cell](src/cell.gleam)
- [gol (Main)](src/gol.gleam)
- [grid](src/grid.gleam)
- [lib](src/lib.gleam)
- [location](src/location.gleam)
- [neighbourhood](src/neighbourhood.gleam)
- [rule](src/rule.gleam)
- [ruleset](src/ruleset.gleam)

:pushpin: And also the following test modules:

- [cell_test](test/cell_test.gleam)
- [gol_test](test/gol_test.gleam)
- [grid_test](test/grid_test.gleam)
- [lib_test](test/lib_test.gleam)
- [location_test](test/location_test.gleam)
- [neighbourhood_test](test/neighbourhood_test.gleam)
- [rule_test](test/rule_test.gleam)
- [ruleset_test](test/ruleset_test.gleam)

### Todo

:pushpin: Complete the source modules:

- [ ] Complete cell
- [ ] Complete gol (Main)
- [ ] Complete grid
- [ ] Complete lib
- [ ] Complete location
- [ ] Complete neighbourhood
- [ ] Complete rule
- [ ] Complete ruleset

:pushpin: Complete the test modules:

- [ ] Complete cell_test
- [ ] Complete gol_test
- [ ] Complete grid_test
- [ ] Complete lib_test
- [ ] Complete location_test
- [ ] Complete neighbourhood_test
- [ ] Complete rule_test
- [ ] Complete ruleset_test

:pushpin: Complete the documentation:

- [X] Complete the README

:pushpin: Complete the project:

- [ ] Complete the project (GOL)

#### Requirements

1) [Gleam](https://gleam.run) – The Gleam programming language, version 1.0.0 or later (As Gleam is a fairly new language, I try to always use the latest version and update the codebase to match it, same goes for the packages used)
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

- I will be exploring other kinds of cellular automata in future projects, thats the reason for some design choices that I made in this project.
- I decided to read the Gleam documentation after writing alot of code by just trialing and erroring, that made me re-write all of the codebase.
- Memoization is not implemented yet but will be eventually, when it is, I will update or remove this note.
- The project will include a web application in the future, which will be accessible at [https://ardauzan.github.io/gol](https://ardauzan.github.io/gol), when it is, I will remove this note.

##### License

See the included [**License file**](LICENSE.txt). Licensed under the [**MIT License**](https://wikipedia.org/wiki/MIT_License).

###### Have a nice day! :wave:

**--** ***A. Uzan***
