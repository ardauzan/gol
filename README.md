# Game of Life (GOL) and Related Cellular Automata Framework :space_invader:

*A simple implementation of a framework to define and interact with life-like cellular automata, written in Gleam.*

## Overview

This project is a personal exercise in learning the Gleam programming language by implementing a framework to simulate the Game of Life and other variants of life from scratch, using as few third-party libraries as possible. This is a learning tool and **not intended for production use**. The code is **licensed under the MIT License** and is available at [GitHub](https://github.com/ardauzan/gol). Contributions and usage are welcome, but please credit the project if you find it helpful. Don't forget to give it a star if you like it! :star:

I want to add that I did not look at any of the other implementations of the Game of Life or other cellular automata, so I am not sure if there are any similarities or known non-idealities between this implementation and the others. If you find any, please let me know!

I referred to [this wiki](https://conwaylife.com/wiki) to review some of the known rules and grid states of the Game of Life and other related life-like cellular automata.

## Modules

:pushpin: The project is divided into the following source modules:

- [cell](src/cell.gleam)
- [definitions](src/definitions.gleam)
- [gol (Main)](src/gol.gleam)
- [grid](src/grid.gleam)
- [location](src/location.gleam)
- [neighbourhood](src/neighbourhood.gleam)
- [rule](src/rule.gleam)
- [ruleset](src/ruleset.gleam)
- [tick](src/tick.gleam)

:pushpin: And also the following test modules:

- [cell_test](test/cell_test.gleam)
- [grid_test](test/grid_test.gleam)
- [location_test](test/location_test.gleam)
- [neighbourhood_test](test/neighbourhood_test.gleam)
- [rule_test](test/rule_test.gleam)
- [ruleset_test](test/ruleset_test.gleam)
- [tick_test](test/tick_test.gleam)

### Todo

:pushpin: Complete the source modules:

- [X] Complete cell
- [ ] Complete definitions
- [ ] Complete gol (Main)
- [X] Complete grid
- [X] Complete location
- [X] Complete neighbourhood
- [ ] Complete rule
- [ ] Complete ruleset
- [ ] Complete tick

:pushpin: Complete the test modules:

- [X] Complete cell_test
- [ ] Complete definitions_test
- [ ] Complete gol_test
- [X] Complete grid_test
- [X] Complete location_test
- [X] Complete neighbourhood_test
- [ ] Complete rule_test
- [ ] Complete ruleset_test
- [ ] Complete tick_test

:pushpin: Complete the documentation:

- [X] Complete the README

:pushpin: Complete the project:

- [ ] Complete the Game of Life project

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

- I will be exploring other kinds of cellular automata in future projects, that's the reason for some of the design choices I made in this project.
- I decided to read the Gleam documentation after writing a lot of code by just trial and error, which led me to rewrite the entire codebase.

##### License

See the included [**LICENSE.txt**](LICENSE.txt) for details. Licensed under the [**MIT License**](https://wikipedia.org/wiki/MIT_License).

###### Have a nice day! :wave:

**--** ***A. Uzan***
