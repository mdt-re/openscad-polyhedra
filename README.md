# OpenSCAD Polyhedra

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

An [OpenSCAD](https://www.openscad.org/) library for designing (mostly) regular polyhedra. Currently available are all [Platonic](https://en.wikipedia.org/wiki/Platonic_solid) and [Archimedean](https://en.wikipedia.org/wiki/Archimedean_solid) solids, as well as [prisms](https://en.wikipedia.org/wiki/Prism_(geometry)) and [antiprisms](https://en.wikipedia.org/wiki/Antiprism).


## Documentation

Include the library and list the available polyhedra using *list_polyhedra()*:
```OpenSCAD
use <polyhedra.scad>;
echo(list_polyhedra());
```
All of the polyhedra can be drawn using the *draw_polyhedron()* function:
```OpenSCAD
draw_polyhedron(id, a = 1, n = 5, m = 2, r = 0, convexity = 1)
  id:         the name of the polyhedron
  a:          [optional] the length of the base edge
  n:          [optional] only for regular n-gon polyhedra; number of edges for the base n-gon
  m:          [optional] only for regular star n-gon polyhedra; m completes the Schläfli symbol {n/m}
  r:          [optional] radius of the circumscribed sphere (overwrites a if non-zero)
  convexity:  [optional] parameter of polyhedron function in OpenSCAD
```
by specifying either the edge length (*a*) or circumradius (*r*):
```OpenSCAD
function random_element(list) = list[floor(rands(0, len(list), 1)[0])];
draw_polyhedron(random_element(list_polyhedra()), r = 10);
```
For (semi-)regular polyhedra the circumradius intersects with all vertices, for more irregular shapes the circumradius (r) is defined as the smallest sphere that fully encloses the polyhedron. Other functions are:
```OpenSCAD
draw_polyhedron_wire_frame(id, a = 1, n = 5, m = 2, r = 0, t = 1)
draw_polyhedron_panels(id, a = 1, n = 5, m = 2, r = 0, t = 1)
polyhedron_vertices(id, n = 5, m = 2) 
polyhedron_faces(id, n = 5, m = 2)
polyhedron_edges(id, n = 5, m = 2)
circumradius_factor(id, n = 5, m = 2)
polyhedron_faces_center(id)
polyhedron_faces_orientation(id)
polyhedron_faces_inradius(id)
```


## Examples

See the [examples](examples) folder for more detailed explanations of the functionality. This folder also contains some interesting examples which can be 3d printed.


## Bugs & Feedback

For bugs and feedback please use the [Github Issues](https://github.com/mdt-re/openscad-polyhedra/issues). Pull requests are also very much appreciated.


## More
You can follow me on [mdt.re](http://mdt.re/blog) for more background information and other polyhedra-related topics.
