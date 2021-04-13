# Examples

Examples for the OpenSCAD Polyhedra library.

## Polyhedral Dice

Dice can easily be designed using this library, based on polyhedra that provide equal probability landing on each of its faces. Use the dice() function:
```OpenSCAD
dice(id = "hexahedron", symbols = [], a = 32, r = 0, inset = 1, rounding = 1, font = "Noto Sans Symbols:style=Regular")
  id:         the name of the polyhedron
  symbols:    a list of symbols to be drawn on the faces
  a:          [optional] the length of the base edge
  r:          [optional] radius of the circumscribed sphere (overwrites a if non-zero)
  inset:      the depth of the symbols
  rounding:   rounding of the dice
  font:       font for the symbols
```

## Tube Connectors

Models of polyhedra can be constructed in a variety of ways, one of them by connecting tubes that serve as the edges of the polyhedra. In this example small connector pins are modelled for all the polyhedra in the library. These can then be 3d printed, and combined with some tubes form a nice wire frame model of the polyhedra. Just open the tube_connectors.scad file and modify the parameters under settings to adapt to the tubes you have available. Cut the tubes to the indicated length and assemble the model.

## Polyhedral Graphs

[Polyhedral graphs](https://en.wikipedia.org/wiki/Polyhedral_graph) are generated in this example using the [Schlegel projection](https://en.wikipedia.org/wiki/Schlegel_diagram)
