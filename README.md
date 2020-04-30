# OpenSCAD Polyhedra

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

An [OpenSCAD](https://www.openscad.org/) library for designing (mostly) regular polyhedra. Currently available are all [Platonic](https://en.wikipedia.org/wiki/Platonic_solid) and [Archimedean](https://en.wikipedia.org/wiki/Archimedean_solid) solids, as well as [prisms](https://en.wikipedia.org/wiki/Prism_(geometry)) and [antiprisms](https://en.wikipedia.org/wiki/Antiprism).


## Usage

Include the library and list the available polyhedra:

	use <polyhedra.scad>;
	echo(list_polyhedra());

You can either call the polyhedra directly to draw it or via the draw_polyhedron function and specify either the edge length (a) or circumradius (r):

	icosidodecahedron(a = 12);

	function random_element(list) = list[floor(rands(0, len(list), 1)[0])];
	draw_polyhedron(random_element(list_polyhedra()), r = 10);

For (semi-)regular polyhedra the circumradius intersects with all vertices, for more irregular shapes the circumradius is defined as the smallest sphere that fully encloses the polyhedron.


## Examples

See the [examples](examples) folder.


## Bugs and Feedback

For bugs and feedback please use the [Github Issues](https://github.com/mdt-re/openscad-polyhedra/issues). Pull requests are also very much appreciated.


## More
You can follow me on [mdt.re](http://mdt.re/blog) for more background information and other polyhedra-related topics.
