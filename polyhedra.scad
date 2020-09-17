/* Polyhedra Library
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Library for the drawing of polyhedra. Contains the following polyhedra:
 *
 * |---------------------------------|-----------------|
 * | id                              |  F  |  E  |  V  |
 * |---------------------------------|-----------------|
 * | --- platonic solids ------------| --------------- |
 * | tetrahedron                     |   4 |   6 |   4 | 
 * | hexahedron                      |   6 |  12 |   8 |
 * | octahedron                      |   8 |  12 |   6 |
 * | dodecahedron                    |  12 |  30 |  20 |
 * | icosahedron                     |  20 |  30 |  12 |
 * | --- archimedean solids -------- | --------------- |
 * | truncated_tetrahedron           |   8 |  18 |  12 |
 * | cuboctahedron                   |  14 |  24 |  12 |
 * | truncated_cube                  |  14 |  36 |  24 |
 * | truncated_octahedron            |  14 |  36 |  24 |
 * | rhombicuboctahedron             |  26 |  48 |  24 |
 * | truncated_cuboctahedron         |  26 |  72 |  48 |
 * | snub_cube                       |  38 |  60 |  24 |
 * | icosidodecahedron               |  32 |  60 |  30 |
 * | truncated_dodecahedron          |  32 |  90 |  60 |
 * | truncated_icosahedron           |  32 |  90 |  60 |
 * | rhombicosidodecahedron          |  62 | 120 |  60 |
 * | truncated_icosidodecahedron     |  62 | 120 | 120 |
 * | snub_dodecahedron               |  92 | 150 |  60 |
 * | --- regular n-gon polyhedra --- | --------------- |
 * | prism                           | 2+n |  3n |  2n |
 * | antiprism                       |2n+2 |  4n |  2n |
 * | trapezohedron (TODO)            |  2n |  4n | 2n+2|
 * | star_prism (TODO)               |     |     |     |
 * | star_dipyramid (TODO)           |     |     |     |
 * | --- catalan solids ------------ | --------------- |
 * | triakis_tetrahedron             |  12 |  18 |   8 |
 * | rhombic_dodecahedron            |  12 |  24 |  14 |
 * | triakis_octahedron              |  24 |  36 |  14 |
 * | tetrakis_hexahedron             |  24 |  36 |  14 |
 * | deltoidal_icositetrahedron      |  24 |  48 |  26 |
 * | rhombic_triacontahedron         |  30 |  60 |  32 |
 * | --- johnson solids ------------ | --------------- |
 * | square pyramid [J1]             |   5 |   8 |   5 |
 * | pentagonal_pyramid [J2]         |   6 |  10 |   6 |
 * | triangular_copula [J3]          |   8 |  15 |   9 |
 * | square_copula [J4]              |  10 |  20 |  12 |
 * | pentagonal_copula [J5]          |  12 |  25 |  15 |
 * | pentagonal_rotunda [J6]         |  17 |  35 |  20 |
 * | --- regular star polyhedra ---- | --------------- |
 * | small_stellated_dodecahedron    |  12 |  30 |  12 |
 * |---------------------------------|-----------------|
 *
 * The following functions are available:
 * |---------------------------------|---------------------------------------------------|
 * | function                        | description                                       |
 * |---------------------------------|---------------------------------------------------|
 * | list_polyhedra                  | lists all available polyhedra                     |
 * | draw_polyhedron                 | draws the given polyhedron                        |
 * | draw_polyhedron_wire_frame      | draws a wire frame for the specified polyhedron   |
 * | draw_polyhedron_panels          | draws panels at the specified polyhedron faces    |
 * | --- properties ---------------- | ------------------------------------------------- |
 * | polyhedron_vertices             | returns the polyhedron vertex coordinates         |
 * | polyhedron_faces                | returns the vertex numbers that form the faces    |
 * | polyhedron_edges                | returns the vertex numbers that form the edges    |
 * | circumradius_factor             | returns the circumradius factor xi (R = xi * a)   |
 * | --- topology ------------------ | ------------------------------------------------- |
 * | vertices_connected_to_vertex    | returns all vertices connected to vertex (v. edge)| 
 * | edges_connected_to_vertex       | returns all edges connected to vertex             | 
 * | edges_connected_to_edge         | returns all edges connected to edge (v. vertex)   | 
 * | edges_connected_to_face         | returns all edges connected to face               | 
 * | faces_connected_to_vertex       | returns all faces connected to vertex             | 
 * | faces_connected_to_edge         | returns all faces connected to edge               | 
 * | faces_connected_to_face         | returns all faces connected to face (v. edge)     |
 * | get_all_edges                   | returns all edges of a polyhedra given its faces  |
 * | --- geometry ------------------ | ------------------------------------------------- |
 * | polyhedron_faces_center         | returns the coordinates of faces' centers         |
 * | polyhedron_faces_orientation    | returns the orientation to xy-plane of the faces  |
 * | polyhedron_faces_inradius       | returns the inner radius of the faces             |
 * | dihedral_angle                  | returns the dihedral angle between face-edge-face |
 * | partial_dihedral_angle          | returns the angle between face-edge-center        |
 * | --- debugging ----------------- | ------------------------------------------------- | 
 * | number_vertices                 | display numbers at all polyhedron vertices        |
 * | number_faces                    | display numbers at all polyhedron faces           |
 * | number_edges                    | display numbers at all polyhedron edges           |
 * |---------------------------------|---------------------------------------------------|
 * 
 * Short usage documentation:
 *
 *  draw_polyhedron(id, a = 1, n = 5, m = 2, r = 0, convexity = 1)
 *   id:         the name of the polyhedron
 *   a:          [optional] the length of the base edge
 *   n:          [optional] only for regular n-gon polyhedra; number of edges for the base n-gon
 *   m:          [optional] only for regular star n-gon polyhedra; m completes the Schläfli symbol {n/m}
 *   r:          [optional] radius of the circumscribed sphere (overwrites a if non-zero)
 *   convexity:  [optional] parameter of polyhedron function in OpenSCAD
 *
*/


/////////////////
// Open Issues //
/////////////////

// Decide whether we want the shortest edge or longest edge to be unity for Catalan solids.

// Mirror images for snub_cube and snub_dodecahedron. 

// Fix inscribed circle radius for non-regular polygon faces.

// Figure out circumradius for Johnson solids.

// Implement height for several polyhedra categories: prism, antiprism.

// Check preview for non-convex polyhedra with cut-outs.

// Properly test topology functions.


///////////////
// Constants //
///////////////

// Mathematical constants.
PHI = (1 + sqrt(5)) / 2;
TRIBONACCI = (1 + pow(19 - 3 * sqrt(33), 1/3) + pow(19 + 3 * sqrt(33), 1/3)) / 3;


/////////////
// Drawing //
/////////////
	
// Returns a list of the available polyhedra in this library.
function list_polyhedra() =
[
	// Platonic solids.
	"tetrahedron", "hexahedron", "octahedron", "dodecahedron", "icosahedron", 
	// Archimedean solids.
	"truncated_tetrahedron", "cuboctahedron", "truncated_cube", "truncated_octahedron", "rhombicuboctahedron", "truncated_cuboctahedron", "snub_cube", "icosidodecahedron", "truncated_dodecahedron", "truncated_icosahedron", "rhombicosidodecahedron", "truncated_icosidodecahedron", "snub_dodecahedron",
	// Regular N-gon Polyhedra.
	"prism", "antiprism", "trapezohedron", "star_prism", "star_dipyramid", 
	// Catalan solids.
	"triakis_tetrahedron", "rhombic_dodecahedron", "triakis_octahedron", "tetrakis_hexahedron", "deltoidal_icositetrahedron", "rhombic_triacontahedron",
	// Johnson solids.
	"square_pyramid", "pentagonal_pyramid", "triangular_copula", "square_copula", "pentagonal_copula", "pentagonal_rotunda",
	// Regular star polyhedra.
	"small_stellated_dodecahedron"
];

// Draws the specified polyhedron.
module draw_polyhedron(id, a = 1, n = 5, m = 2, r = 0, convexity = 1)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_polyhedron: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id, n = n, m = m);
	faces = polyhedron_faces(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	polyhedron(vertices * side, faces, convexity);
}

// Draws the specified polyhedron as a wire frame of all edges, with wire thickness (t).
module draw_polyhedron_wire_frame(id, a = 1, n = 5, m = 2, r = 0, t = 1)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_polyhedron_wire_frame: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	for (e = edges)
	{
		v1 = side * vertices[e[0]];
		v2 = side * vertices[e[1]];
		c = (v1 + v2) / 2;
		h = norm(v1 - v2);
		translate(c)
			rotate(rotation_to_points(v1, v2))
				minkowski()
				{
					cylinder(h = h, r = 0.000001, center = true);
					sphere(r = t / 2, $fn = 12);
				}
	}
}

// Draws the specified polyhedron as a set of polygon panels that cover the faces, with panel thickness (t).
module draw_polyhedron_panels(id, a = 1, n = 5, m = 2, r = 0, t = 1)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_polyhedron_wire_frame: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id);
	faces = polyhedron_faces(id);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	for (face = faces)
	{
		polygon_vertices = [for (v = face) side * vertices[v]];
		polygon_panel(polygon_vertices, t);
	}
}

// Creates the polygon panel for each of the polyhedron's faces.
module polygon_panel(polygon_vertices, t = 1)
{
	// Calculate polygon center and orthonormal.
	center = mean(polygon_vertices);
	orthonormal = plane_orthonormal(polygon_vertices);
	// Add vertices to make polygon 3D.
	unit_center = center / norm(center);
	orthonormal_points = [for (p = polygon_vertices) orthonormal];
	polygon_points = concat(polygon_vertices - t / 2 * orthonormal_points, polygon_vertices + t / 2 * orthonormal_points);
	// Create faces according to number of polygon vertices.
	polygon_faces = right_prism_faces(len(polygon_vertices));
	polyhedron(polygon_points, polygon_faces, 10);
}


///////////////////////////
// Polyhedron Properties //
///////////////////////////

// Returns the polyhedron vertices as a list of 3D coordinates.
// The vertex coordinates are normalized such that the edge length (a) equals 1.
function polyhedron_vertices(id, n = 5, m = 2) =
(
	// Platonic solids.
	id == "tetrahedron" ?
		VERTICES_TETRAHEDRON
	: id == "hexahedron" ?
		VERTICES_HEXAHEDRON
	: id == "octahedron" ?
		VERTICES_OCTAHEDRON
	: id == "dodecahedron" ?
		VERTICES_DODECAHEDRON
	: id == "icosahedron" ?
		VERTICES_ICOSAHEDRON
	// Archimedean solids.
	: id == "truncated_tetrahedron" ?	
		VERTICES_TRUNCATED_TETRAHEDRON
	: id == "cuboctahedron" ?	
		VERTICES_CUBOCTAHEDRON
	: id == "truncated_cube" ?	
		VERTICES_TRUNCATED_CUBE
	: id == "truncated_octahedron" ?
		VERTICES_TRUNCATED_OCTAHEDRON
	: id == "rhombicuboctahedron" ?	
		VERTICES_RHOMBICUBOCTAHEDRON
	: id == "truncated_cuboctahedron" ?
		VERTICES_TRUNCATED_CUBOCTAHEDRON
	: id == "snub_cube" ?
		VERTICES_SNUB_CUBE
	: id == "icosidodecahedron" ?
		VERTICES_ICOSIDODECAHEDRON
	: id == "truncated_dodecahedron" ?
		VERTICES_TRUNCATED_DODECAHEDRON
	: id == "truncated_icosahedron" ?
		VERTICES_TRUNCATED_ICOSAHEDRON
	: id == "rhombicosidodecahedron" ?	
		VERTICES_RHOMBICOSIDODECAHEDRON
	: id == "truncated_icosidodecahedron" ?	
		VERTICES_TRUNCATED_ICOSIDODECAHEDRON
	: id == "snub_dodecahedron" ?
		VERTICES_SNUB_DODECAHEDRON
	// Regular n-gon polyhedra.
	: id == "prism" ?
		VERTICES_PRISM(n = n)
	: id == "antiprism" ?
		VERTICES_ANTIPRISM(n = n)
	: id == "trapezohedron" ?
		VERTICES_TRAPEZOHEDRON(n = n)
	: id == "star_prism" ?
		VERTICES_STAR_PRISM(n = n, m = m)
	: id == "star_dipyramid" ?
		VERTICES_STAR_DIPYRAMID(n = n, m = m)
	// Catalan solids.
	: id == "triakis_tetrahedron" ?
		VERTICES_TRIAKIS_TETRAHEDRON
	: id == "rhombic_dodecahedron" ?
		VERTICES_RHOMBIC_DODECAHEDRON
	: id == "triakis_octahedron" ?
		VERTICES_TRIAKIS_OCTAHEDRON
	: id == "tetrakis_hexahedron" ?
		VERTICES_TETRAKIS_HEXAHEDRON
	: id == "deltoidal_icositetrahedron" ?
		VERTICES_DELTOIDAL_ICOSITETRAHEDRON
	: id == "rhombic_triacontahedron" ?	
		VERTICES_RHOMBIC_TRIACONTAHEDRON
	// Johnson solids.
	: id == "square_pyramid" ?
		VERTICES_SQUARE_PYRAMID
	: id == "pentagonal_pyramid" ?
		VERTICES_PENTAGONAL_PYRAMID
	: id == "triangular_copula" ?
		VERTICES_TRIANGULAR_COPULA
	: id == "square_copula" ?
		VERTICES_SQUARE_COPULA
	: id == "pentagonal_copula" ?
		VERTICES_PENTAGONAL_COPULA
	: id == "pentagonal_rotunda" ?	
		VERTICES_PENTAGONAL_ROTUNDA
	// Regular star polyhedra.
	: id == "small_stellated_dodecahedron" ?
		VERTICES_SMALL_STELLATED_DODECAHEDRON
	:
		undef
);

// Returns the polyhedron faces as a list of connecting vertices.
function polyhedron_faces(id, n = 5, m = 2) =
(
	// Platonic solids.
	id == "tetrahedron" ?
		FACES_TETRAHEDRON
	: id == "hexahedron" ?
		FACES_HEXAHEDRON
	: id == "octahedron" ?
		FACES_OCTAHEDRON
	: id == "dodecahedron" ?
		FACES_DODECAHEDRON
	: id == "icosahedron" ?
		FACES_ICOSAHEDRON
	// Archimedean solids.
	: id == "truncated_tetrahedron" ?	
		FACES_TRUNCATED_TETRAHEDRON
	: id == "cuboctahedron" ?	
		FACES_CUBOCTAHEDRON
	: id == "truncated_cube" ?	
		FACES_TRUNCATED_CUBE
	: id == "truncated_octahedron" ?
		FACES_TRUNCATED_OCTAHEDRON
	: id == "rhombicuboctahedron" ?	
		FACES_RHOMBICUBOCTAHEDRON
	: id == "truncated_cuboctahedron" ?
		FACES_TRUNCATED_CUBOCTAHEDRON
	: id == "snub_cube" ?
		FACES_SNUB_CUBE
	: id == "icosidodecahedron" ?
		FACES_ICOSIDODECAHEDRON
	: id == "truncated_dodecahedron" ?
		FACES_TRUNCATED_DODECAHEDRON
	: id == "truncated_icosahedron" ?
		FACES_TRUNCATED_ICOSAHEDRON
	: id == "rhombicosidodecahedron" ?	
		FACES_RHOMBICOSIDODECAHEDRON
	: id == "truncated_icosidodecahedron" ?	
		FACES_TRUNCATED_ICOSIDODECAHEDRON
	: id == "snub_dodecahedron" ?
		FACES_SNUB_DODECAHEDRON
	// Regular n-gon polyhedra.
	: id == "prism" ?
		FACES_PRISM(n = n)
	: id == "antiprism" ?
		FACES_ANTIPRISM(n = n)
	: id == "trapezohedron" ?
		FACES_TRAPEZOHEDRON(n = n)
	: id == "star_prism" ?
		FACES_STAR_PRISM(n = n, m = m)
	: id == "star_dipyramid" ?
		FACES_STAR_DIPYRAMID(n = n, m = m)
	// Catalan solids.
	: id == "triakis_tetrahedron" ?
		FACES_TRIAKIS_TETRAHEDRON
	: id == "rhombic_dodecahedron" ?
		FACES_RHOMBIC_DODECAHEDRON
	: id == "triakis_octahedron" ?
		FACES_TRIAKIS_OCTAHEDRON
	: id == "tetrakis_hexahedron" ?
		FACES_TETRAKIS_HEXAHEDRON
	: id == "deltoidal_icositetrahedron" ?
		FACES_DELTOIDAL_ICOSITETRAHEDRON
	: id == "rhombic_triacontahedron" ?	
		FACES_RHOMBIC_TRIACONTAHEDRON
	// Johnson solids.
	: id == "square_pyramid" ?
		FACES_SQUARE_PYRAMID
	: id == "pentagonal_pyramid" ?
		FACES_PENTAGONAL_PYRAMID
	: id == "triangular_copula" ?
		FACES_TRIANGULAR_COPULA
	: id == "square_copula" ?
		FACES_SQUARE_COPULA
	: id == "pentagonal_copula" ?
		FACES_PENTAGONAL_COPULA
	: id == "pentagonal_rotunda" ?	
		FACES_PENTAGONAL_ROTUNDA
	// Regular star polyhedra.
	: id == "small_stellated_dodecahedron" ?
		FACES_SMALL_STELLATED_DODECAHEDRON
	:
		undef
);

// Returns the polyhedron edges as a list of vertex pairs.
function polyhedron_edges(id, n = 5, m = 2) = get_all_edges(polyhedron_faces(id, n = n, m = m));

// Returns the circumradius factor xi (R = xi * a).
function circumradius_factor(id, n = 5, m = 2) = 
(
	// Platonic solids.
	id == "tetrahedron" ?
		CIRCUMRADIUS_TETRAHEDRON
	: id == "hexahedron" ?
		CIRCUMRADIUS_HEXAHEDRON
	: id == "octahedron" ?
		CIRCUMRADIUS_OCTAHEDRON
	: id == "dodecahedron" ?
		CIRCUMRADIUS_DODECAHEDRON
	: id == "icosahedron" ?
		CIRCUMRADIUS_ICOSAHEDRON
	// Archimedean solids.
	: id == "truncated_tetrahedron" ?	
		CIRCUMRADIUS_TRUNCATED_TETRAHEDRON
	: id == "cuboctahedron" ?	
		CIRCUMRADIUS_CUBOCTAHEDRON
	: id == "truncated_cube" ?	
		CIRCUMRADIUS_TRUNCATED_CUBE
	: id == "truncated_octahedron" ?
		CIRCUMRADIUS_TRUNCATED_OCTAHEDRON
	: id == "rhombicuboctahedron" ?	
		CIRCUMRADIUS_RHOMBICUBOCTAHEDRON
	: id == "truncated_cuboctahedron" ?
		CIRCUMRADIUS_TRUNCATED_CUBOCTAHEDRON
	: id == "snub_cube" ?
		CIRCUMRADIUS_SNUB_CUBE
	: id == "icosidodecahedron" ?
		CIRCUMRADIUS_ICOSIDODECAHEDRON
	: id == "truncated_dodecahedron" ?
		CIRCUMRADIUS_TRUNCATED_DODECAHEDRON
	: id == "truncated_icosahedron" ?
		CIRCUMRADIUS_TRUNCATED_ICOSAHEDRON
	: id == "rhombicosidodecahedron" ?	
		CIRCUMRADIUS_RHOMBICOSIDODECAHEDRON
	: id == "truncated_icosidodecahedron" ?	
		CIRCUMRADIUS_TRUNCATED_ICOSIDODECAHEDRON
	: id == "snub_dodecahedron" ?
		CIRCUMRADIUS_SNUB_DODECAHEDRON
	// Regular n-gon polyhedra.
	: id == "prism" ?
		CIRCUMRADIUS_PRISM(n = n)
	: id == "antiprism" ?
		CIRCUMRADIUS_ANTIPRISM(n = n)
	: id == "trapezohedron" ?
		CIRCUMRADIUS_TRAPEZOHEDRON(n = n)
	: id == "star_prism" ?
		CIRCUMRADIUS_STAR_PRISM(n = n, m = m)
	: id == "star_dipyramid" ?
		CIRCUMRADIUS_STAR_DIPYRAMID(n = n, m = m)
	// Catalan solids.
	: id == "triakis_tetrahedron" ?
		CIRCUMRADIUS_TRIAKIS_TETRAHEDRON
	: id == "rhombic_dodecahedron" ?
		CIRCUMRADIUS_RHOMBIC_DODECAHEDRON
	: id == "triakis_octahedron" ?
		CIRCUMRADIUS_TRIAKIS_OCTAHEDRON
	: id == "tetrakis_hexahedron" ?
		CIRCUMRADIUS_TETRAKIS_HEXAHEDRON
	: id == "deltoidal_icositetrahedron" ?
		CIRCUMRADIUS_DELTOIDAL_ICOSITETRAHEDRON
	: id == "rhombic_triacontahedron" ?	
		CIRCUMRADIUS_RHOMBIC_TRIACONTAHEDRON
	// Johnson solids.
	: id == "square_pyramid" ?
		CIRCUMRADIUS_SQUARE_PYRAMID
	: id == "pentagonal_pyramid" ?
		CIRCUMRADIUS_PENTAGONAL_PYRAMID
	: id == "triangular_copula" ?
		CIRCUMRADIUS_TRIANGULAR_COPULA
	: id == "square_copula" ?
		CIRCUMRADIUS_SQUARE_COPULA
	: id == "pentagonal_copula" ?
		CIRCUMRADIUS_PENTAGONAL_COPULA
	: id == "pentagonal_rotunda" ?	
		CIRCUMRADIUS_PENTAGONAL_ROTUNDA
	// Regular star polyhedra.
	: id == "small_stellated_dodecahedron" ?
		CIRCUMRADIUS_SMALL_STELLATED_DODECAHEDRON
	:
		undef
);


///////////////////////////
// Data: Platonic Solids //
///////////////////////////

// Source: https://en.wikipedia.org/wiki/Tetrahedron
VERTICES_TETRAHEDRON = [
	[+1/2, 0, -1/sqrt(8)],  //0
	[-1/2, 0, -1/sqrt(8)],  //1
	[0, +1/2, +1/sqrt(8)],  //2
	[0, -1/2, +1/sqrt(8)]   //3
];
FACES_TETRAHEDRON = [
	[1, 0, 2], [0, 1, 3], [0, 3, 2], [1, 2, 3]
];
CIRCUMRADIUS_TETRAHEDRON = sqrt(3 / 8);

// Source: https://en.wikipedia.org/wiki/Cube
VERTICES_HEXAHEDRON = [
	[+1/2, +1/2, +1/2],  //0
	[+1/2, +1/2, -1/2],  //1
	[+1/2, -1/2, +1/2],  //2
	[+1/2, -1/2, -1/2],  //3
	[-1/2, +1/2, +1/2],  //4
	[-1/2, +1/2, -1/2],  //5
	[-1/2, -1/2, +1/2],  //6
	[-1/2, -1/2, -1/2]   //7
];
FACES_HEXAHEDRON = [
	[6, 2, 3, 7], [2, 6, 4, 0], [2, 0, 1, 3],
	[5, 4, 6, 7], [7, 3, 1, 5], [0, 4, 5, 1]
];
CIRCUMRADIUS_HEXAHEDRON = sqrt(3) / 2;

// Source: https://en.wikipedia.org/wiki/Octahedron
VERTICES_OCTAHEDRON = [
	[+1/sqrt(2), 0, 0],  //0
	[-1/sqrt(2), 0, 0],  //1
	[0, +1/sqrt(2), 0],  //2
	[0, -1/sqrt(2), 0],  //3
	[0, 0, +1/sqrt(2)],  //4
	[0, 0, -1/sqrt(2)]   //5
];
FACES_OCTAHEDRON = [
	[3, 4, 0], [4, 3, 1], [1, 2, 4], [2, 0, 4],
	[3, 0, 5], [0, 2, 5], [2, 1, 5], [1, 3, 5]
];
CIRCUMRADIUS_OCTAHEDRON = sqrt(2) / 2;

// Source: https://en.wikipedia.org/wiki/Regular_dodecahedron
VERTICES_DODECAHEDRON = [
	[+PHI/2, +PHI/2, +PHI/2],  //0
	[+PHI/2, +PHI/2, -PHI/2],  //1
	[+PHI/2, -PHI/2, +PHI/2],  //2
	[+PHI/2, -PHI/2, -PHI/2],  //3
	[-PHI/2, +PHI/2, -PHI/2],  //4
	[-PHI/2, +PHI/2, +PHI/2],  //5
	[-PHI/2, -PHI/2, -PHI/2],  //6
	[-PHI/2, -PHI/2, +PHI/2],  //7

	[0, +1/2, +PHI*PHI/2],  //8
	[0, +1/2, -PHI*PHI/2],  //9
	[0, -1/2, +PHI*PHI/2],  //10
	[0, -1/2, -PHI*PHI/2],  //11

	[+1/2, +PHI*PHI/2, 0],  //12
	[+1/2, -PHI*PHI/2, 0],  //13
	[-1/2, +PHI*PHI/2, 0],  //14
	[-1/2, -PHI*PHI/2, 0],  //15
	
	[+PHI*PHI/2, 0, +1/2],  //16
	[-PHI*PHI/2, 0, +1/2],  //17
	[+PHI*PHI/2, 0, -1/2],  //18
	[-PHI*PHI/2, 0, -1/2]   //19
];
FACES_DODECAHEDRON = [
	[8, 0, 16, 2, 10], [0, 8, 5, 14, 12], [0, 12, 1, 18, 16],
	[12, 14, 4, 9, 1], [8, 10, 7, 17, 5], [5, 17, 19, 4, 14],
	[19, 17, 7, 15, 6], [15, 7, 10, 2, 13], [13, 2, 16, 18, 3],
	[6, 15, 13, 3, 11], [11, 3, 18, 1, 9], [11, 9, 4, 19, 6]
];
CIRCUMRADIUS_DODECAHEDRON = sqrt(3) * PHI / 2;

// Source: https://en.wikipedia.org/wiki/Regular_icosahedron
VERTICES_ICOSAHEDRON = [
	[0, +1/2, +PHI/2],  //0
	[0, +1/2, -PHI/2],  //1
	[0, -1/2, +PHI/2],  //2
	[0, -1/2, -PHI/2],  //3
	[+PHI/2, 0, +1/2],  //4
	[+PHI/2, 0, -1/2],  //5
	[-PHI/2, 0, +1/2],  //6
	[-PHI/2, 0, -1/2],  //7
	[+1/2, +PHI/2, 0],  //8
	[+1/2, -PHI/2, 0],  //9
	[-1/2, +PHI/2, 0],  //10
	[-1/2, -PHI/2, 0]   //11
];
FACES_ICOSAHEDRON = [
	[2, 0, 4], [0, 2, 6], [8, 4, 0], [11, 7, 6], [2, 9, 11],
	[2, 11, 6], [2, 4, 9], [3, 7, 11], [3, 11, 9], [3, 9, 5],
	[3, 5, 1], [3, 1, 7], [1, 10, 7], [1, 8, 10], [10, 8, 0],
	[10, 0, 6], [5, 9, 4], [4, 8, 5], [8, 1, 5], [10, 6, 7]
];
CIRCUMRADIUS_ICOSAHEDRON = PHI * sin(180 / 5);


//////////////////////////////
// Data: Archimedean Solids //
//////////////////////////////

// Source: https://en.wikipedia.org/wiki/Truncated_tetrahedron
VERTICES_TRUNCATED_TETRAHEDRON = [
	[+3/sqrt(8), +1/sqrt(8), +1/sqrt(8)],  //0
	[+1/sqrt(8), +3/sqrt(8), +1/sqrt(8)],  //1
	[+1/sqrt(8), +1/sqrt(8), +3/sqrt(8)],  //2
	[-3/sqrt(8), -1/sqrt(8), +1/sqrt(8)],  //3
	[-1/sqrt(8), -3/sqrt(8), +1/sqrt(8)],  //4
	[-1/sqrt(8), -1/sqrt(8), +3/sqrt(8)],  //5
	[-3/sqrt(8), +1/sqrt(8), -1/sqrt(8)],  //6
	[-1/sqrt(8), +3/sqrt(8), -1/sqrt(8)],  //7
	[-1/sqrt(8), +1/sqrt(8), -3/sqrt(8)],  //8
	[+3/sqrt(8), -1/sqrt(8), -1/sqrt(8)],  //9
	[+1/sqrt(8), -3/sqrt(8), -1/sqrt(8)],  //10
	[+1/sqrt(8), -1/sqrt(8), -3/sqrt(8)]   //11
];
FACES_TRUNCATED_TETRAHEDRON = [
	[0, 2, 1], [3, 5, 4], [6, 8, 7], [9, 11, 10],
	[2, 0, 9, 10, 4, 5], [1, 7, 8, 11, 9, 0],
	[7, 1, 2, 5, 3, 6], [3, 4, 10, 11, 8, 6]
];
CIRCUMRADIUS_TRUNCATED_TETRAHEDRON = sqrt(11 / 8);

// Source: https://en.wikipedia.org/wiki/Cuboctahedron
VERTICES_CUBOCTAHEDRON = [
	[+1/sqrt(2), +1/sqrt(2), 0],  //0
	[+1/sqrt(2), -1/sqrt(2), 0],  //1
	[-1/sqrt(2), +1/sqrt(2), 0],  //2
	[-1/sqrt(2), -1/sqrt(2), 0],  //3
	[+1/sqrt(2), 0, +1/sqrt(2)],  //4
	[+1/sqrt(2), 0, -1/sqrt(2)],  //5
	[-1/sqrt(2), 0, +1/sqrt(2)],  //6
	[-1/sqrt(2), 0, -1/sqrt(2)],  //7
	[0, +1/sqrt(2), +1/sqrt(2)],  //8
	[0, +1/sqrt(2), -1/sqrt(2)],  //9
	[0, -1/sqrt(2), +1/sqrt(2)],  //10
	[0, -1/sqrt(2), -1/sqrt(2)]   //11
];
FACES_CUBOCTAHEDRON = [
	[6, 8, 4, 10], [4, 0, 5, 1], [3, 10, 1, 11],
	[8, 2, 9, 0], [6, 3, 7, 2], [7, 11, 5, 9],
	
	[8, 6, 2], [4, 8, 0], [10, 4, 1], [6, 10, 3],
	[0, 9, 5], [1, 5, 11], [3, 11, 7], [2, 7, 9]
];
CIRCUMRADIUS_CUBOCTAHEDRON = 1;

// Source: https://en.wikipedia.org/wiki/Truncated_cube
VERTICES_TRUNCATED_CUBE = [
	[+(sqrt(2) - 1), +1, +1],  //0
	[+(sqrt(2) - 1), +1, -1],  //1
	[+(sqrt(2) - 1), -1, +1],  //2
	[+(sqrt(2) - 1), -1, -1],  //3
	[-(sqrt(2) - 1), +1, +1],  //4
	[-(sqrt(2) - 1), +1, -1],  //5
	[-(sqrt(2) - 1), -1, +1],  //6
	[-(sqrt(2) - 1), -1, -1],  //7

	[+1, +(sqrt(2) - 1), +1],  //8
	[+1, +(sqrt(2) - 1), -1],  //9
	[+1, -(sqrt(2) - 1), +1],  //10
	[+1, -(sqrt(2) - 1), -1],  //11
	[-1, +(sqrt(2) - 1), +1],  //12
	[-1, +(sqrt(2) - 1), -1],  //13
	[-1, -(sqrt(2) - 1), +1],  //14
	[-1, -(sqrt(2) - 1), -1],  //15

	[+1, +1, +(sqrt(2) - 1)],  //16
	[+1, +1, -(sqrt(2) - 1)],  //17
	[+1, -1, +(sqrt(2) - 1)],  //18
	[+1, -1, -(sqrt(2) - 1)],  //19
	[-1, +1, +(sqrt(2) - 1)],  //20
	[-1, +1, -(sqrt(2) - 1)],  //21
	[-1, -1, +(sqrt(2) - 1)],  //22
	[-1, -1, -(sqrt(2) - 1)],  //23
] / (2 * sqrt(2) - 2);
FACES_TRUNCATED_CUBE = [
	[4, 0, 8, 10, 2, 6, 14, 12], [0, 4, 20, 21, 5, 1, 17, 16], [1, 5, 13, 15, 7, 3, 11, 9], [2, 18, 19, 3, 7, 23, 22, 6], [10, 8, 16, 17, 9, 11, 19, 18], [12, 14, 22, 23, 15, 13, 21, 20],
		
	[18, 2, 10], [14, 6, 22], [4, 12, 20], [8, 0, 16], [19, 11, 3], [23, 7, 15], [21, 13, 5], [17, 1, 9]
];
CIRCUMRADIUS_TRUNCATED_CUBE = sqrt(7 + 4 * sqrt(2)) / 2;

// Source: https://en.wikipedia.org/wiki/Truncated_octahedron
VERTICES_TRUNCATED_OCTAHEDRON = [
	[0, +1/sqrt(2), +2/sqrt(2)],  //0
	[0, +1/sqrt(2), -2/sqrt(2)],  //1
	[0, -1/sqrt(2), +2/sqrt(2)],  //2
	[0, -1/sqrt(2), -2/sqrt(2)],  //3

	[0, +2/sqrt(2), +1/sqrt(2)],  //4
	[0, +2/sqrt(2), -1/sqrt(2)],  //5
	[0, -2/sqrt(2), +1/sqrt(2)],  //6
	[0, -2/sqrt(2), -1/sqrt(2)],  //7
	
	[+1/sqrt(2), 0, +2/sqrt(2)],  //8
	[+1/sqrt(2), 0, -2/sqrt(2)],  //9
	[-1/sqrt(2), 0, +2/sqrt(2)],  //10
	[-1/sqrt(2), 0, -2/sqrt(2)],  //11

	[+2/sqrt(2), 0, +1/sqrt(2)],  //12
	[+2/sqrt(2), 0, -1/sqrt(2)],  //13
	[-2/sqrt(2), 0, +1/sqrt(2)],  //14
	[-2/sqrt(2), 0, -1/sqrt(2)],  //15

	[+1/sqrt(2), +2/sqrt(2), 0],  //16
	[+1/sqrt(2), -2/sqrt(2), 0],  //17
	[-1/sqrt(2), +2/sqrt(2), 0],  //18
	[-1/sqrt(2), -2/sqrt(2), 0],  //19
	
	[+2/sqrt(2), +1/sqrt(2), 0],  //20
	[+2/sqrt(2), -1/sqrt(2), 0],  //21
	[-2/sqrt(2), +1/sqrt(2), 0],  //22
	[-2/sqrt(2), -1/sqrt(2), 0]   //23
];
FACES_TRUNCATED_OCTAHEDRON = [
	[22, 14, 23, 15], [12, 20, 13, 21], [4, 18, 5, 16],
	[6, 17, 7, 19], [0, 8, 2, 10], [1, 11, 3, 9],
	
	[6, 2, 8, 12, 21, 17], [2, 6, 19, 23, 14, 10], [0, 4, 16, 20, 12, 8], [11, 15, 23, 19, 7, 3],
	[1, 9, 13, 20, 16, 5], [14, 22, 18, 4, 0, 10], [1, 5, 18, 22, 15, 11], [3, 7, 17, 21, 13, 9]
];
CIRCUMRADIUS_TRUNCATED_OCTAHEDRON = sqrt(10) / 2;

// Source: https://en.wikipedia.org/wiki/Rhombicuboctahedron
VERTICES_RHOMBICUBOCTAHEDRON = [
	[+1/2, +1/2, +(1 + sqrt(2))/2],  //0
	[+1/2, +1/2, -(1 + sqrt(2))/2],  //1
	[+1/2, -1/2, +(1 + sqrt(2))/2],  //2
	[+1/2, -1/2, -(1 + sqrt(2))/2],  //3
	[-1/2, +1/2, +(1 + sqrt(2))/2],  //4
	[-1/2, +1/2, -(1 + sqrt(2))/2],  //5
	[-1/2, -1/2, +(1 + sqrt(2))/2],  //6
	[-1/2, -1/2, -(1 + sqrt(2))/2],  //7

	[+1/2, +(1 + sqrt(2))/2, +1/2],  //8
	[+1/2, +(1 + sqrt(2))/2, -1/2],  //9
	[+1/2, -(1 + sqrt(2))/2, +1/2],  //10
	[+1/2, -(1 + sqrt(2))/2, -1/2],  //11
	[-1/2, +(1 + sqrt(2))/2, +1/2],  //12
	[-1/2, +(1 + sqrt(2))/2, -1/2],  //13
	[-1/2, -(1 + sqrt(2))/2, +1/2],  //14
	[-1/2, -(1 + sqrt(2))/2, -1/2],  //15
	
	[+(1 + sqrt(2))/2, +1/2, +1/2],  //16
	[+(1 + sqrt(2))/2, +1/2, -1/2],  //17
	[+(1 + sqrt(2))/2, -1/2, +1/2],  //18
	[+(1 + sqrt(2))/2, -1/2, -1/2],  //19
	[-(1 + sqrt(2))/2, +1/2, +1/2],  //20
	[-(1 + sqrt(2))/2, +1/2, -1/2],  //21
	[-(1 + sqrt(2))/2, -1/2, +1/2],  //22
	[-(1 + sqrt(2))/2, -1/2, -1/2]   //23
];
FACES_RHOMBICUBOCTAHEDRON = [
	[0, 2, 6, 4], [3, 1, 5, 7], [9, 8, 12, 13],
	[10, 11, 15, 14], [16, 17, 19, 18], [21, 20, 22, 23],
	
	[2, 0, 16, 18], [6, 2, 10, 14], [4, 6, 22, 20], [0, 4, 12, 8],
	[1, 3, 19, 17], [3, 7, 15, 11], [7, 5, 21, 23], [5, 1, 9, 13],
	[19, 11, 10, 18], [8, 9, 17, 16], [13, 12, 20, 21], [14, 15, 23, 22],
	
	[11, 19, 3], [0, 8, 16], [1, 17, 9], [2, 18, 10],
	[4, 20, 12], [5, 13, 21], [6, 14, 22], [7, 23, 15]
];
CIRCUMRADIUS_RHOMBICUBOCTAHEDRON = sqrt(5 + 2 * sqrt(2)) / 2;

// Source: https://en.wikipedia.org/wiki/Truncated_cuboctahedron
VERTICES_TRUNCATED_CUBOCTAHEDRON = [
	[+1/2, +(1 + sqrt(2))/2, +(1/2 + sqrt(2))],  //0
	[+1/2, +(1 + sqrt(2))/2, -(1/2 + sqrt(2))],  //1
	[+1/2, -(1 + sqrt(2))/2, +(1/2 + sqrt(2))],  //2
	[+1/2, -(1 + sqrt(2))/2, -(1/2 + sqrt(2))],  //3
	[-1/2, +(1 + sqrt(2))/2, +(1/2 + sqrt(2))],  //4
	[-1/2, +(1 + sqrt(2))/2, -(1/2 + sqrt(2))],  //5
	[-1/2, -(1 + sqrt(2))/2, +(1/2 + sqrt(2))],  //6
	[-1/2, -(1 + sqrt(2))/2, -(1/2 + sqrt(2))],  //7
	
	[+1/2, +(1/2 + sqrt(2)), +(1 + sqrt(2))/2],  //8
	[+1/2, +(1/2 + sqrt(2)), -(1 + sqrt(2))/2],  //9
	[+1/2, -(1/2 + sqrt(2)), +(1 + sqrt(2))/2],  //10
	[+1/2, -(1/2 + sqrt(2)), -(1 + sqrt(2))/2],  //11
	[-1/2, +(1/2 + sqrt(2)), +(1 + sqrt(2))/2],  //12
	[-1/2, +(1/2 + sqrt(2)), -(1 + sqrt(2))/2],  //13
	[-1/2, -(1/2 + sqrt(2)), +(1 + sqrt(2))/2],  //14
	[-1/2, -(1/2 + sqrt(2)), -(1 + sqrt(2))/2],  //15
	
	[+(1 + sqrt(2))/2, +1/2, +(1/2 + sqrt(2))],  //16
	[+(1 + sqrt(2))/2, +1/2, -(1/2 + sqrt(2))],  //17
	[+(1 + sqrt(2))/2, -1/2, +(1/2 + sqrt(2))],  //18
	[+(1 + sqrt(2))/2, -1/2, -(1/2 + sqrt(2))],  //19
	[-(1 + sqrt(2))/2, +1/2, +(1/2 + sqrt(2))],  //20
	[-(1 + sqrt(2))/2, +1/2, -(1/2 + sqrt(2))],  //21
	[-(1 + sqrt(2))/2, -1/2, +(1/2 + sqrt(2))],  //22
	[-(1 + sqrt(2))/2, -1/2, -(1/2 + sqrt(2))],  //23
	
	[+(1 + sqrt(2))/2, +(1/2 + sqrt(2)), +1/2],  //24
	[+(1 + sqrt(2))/2, +(1/2 + sqrt(2)), -1/2],  //25
	[+(1 + sqrt(2))/2, -(1/2 + sqrt(2)), +1/2],  //26
	[+(1 + sqrt(2))/2, -(1/2 + sqrt(2)), -1/2],  //27
	[-(1 + sqrt(2))/2, +(1/2 + sqrt(2)), +1/2],  //28
	[-(1 + sqrt(2))/2, +(1/2 + sqrt(2)), -1/2],  //29
	[-(1 + sqrt(2))/2, -(1/2 + sqrt(2)), +1/2],  //30
	[-(1 + sqrt(2))/2, -(1/2 + sqrt(2)), -1/2],  //31
	
	[+(1/2 + sqrt(2)), +1/2, +(1 + sqrt(2))/2],  //32
	[+(1/2 + sqrt(2)), +1/2, -(1 + sqrt(2))/2],  //33
	[+(1/2 + sqrt(2)), -1/2, +(1 + sqrt(2))/2],  //34
	[+(1/2 + sqrt(2)), -1/2, -(1 + sqrt(2))/2],  //35
	[-(1/2 + sqrt(2)), +1/2, +(1 + sqrt(2))/2],  //36
	[-(1/2 + sqrt(2)), +1/2, -(1 + sqrt(2))/2],  //37
	[-(1/2 + sqrt(2)), -1/2, +(1 + sqrt(2))/2],  //38
	[-(1/2 + sqrt(2)), -1/2, -(1 + sqrt(2))/2],  //39
	
	[+(1/2 + sqrt(2)), +(1 + sqrt(2))/2, +1/2],  //40
	[+(1/2 + sqrt(2)), +(1 + sqrt(2))/2, -1/2],  //41
	[+(1/2 + sqrt(2)), -(1 + sqrt(2))/2, +1/2],  //42
	[+(1/2 + sqrt(2)), -(1 + sqrt(2))/2, -1/2],  //43
	[-(1/2 + sqrt(2)), +(1 + sqrt(2))/2, +1/2],  //44
	[-(1/2 + sqrt(2)), +(1 + sqrt(2))/2, -1/2],  //45
	[-(1/2 + sqrt(2)), -(1 + sqrt(2))/2, +1/2],  //46
	[-(1/2 + sqrt(2)), -(1 + sqrt(2))/2, -1/2]   //47
	
];
FACES_TRUNCATED_CUBOCTAHEDRON = [
	[0, 16, 18, 2, 6, 22, 20, 4], [32, 40, 41, 33, 35, 43, 42, 34], [36, 38, 46, 47, 39, 37, 45, 44], [8, 12, 28, 29, 13, 9, 25, 24], [14, 10, 26, 27, 11, 15, 31, 30], [1, 5, 21, 23, 7, 3, 19, 17],
	
	[22, 6, 14, 30, 46, 38], [4, 20, 36, 44, 28, 12], [16, 0, 8, 24, 40, 32], [2, 18, 34, 42, 26, 10], [43, 35, 19, 3, 11, 27], [7, 23, 39, 47, 31, 15], [21, 5, 13, 29, 45, 37], [9, 1, 17, 33, 41, 25], 
	
	[6, 2, 10, 14], [20, 22, 38, 36], [0, 4, 12, 8], [18, 16, 32, 34], [43, 27, 26, 42], [46, 30, 31, 47], [40, 24, 25, 41], [44, 45, 29, 28], [9, 13, 5, 1], [37, 39, 23, 21], [15, 11, 3, 7], [35, 33, 17, 19]
];
CIRCUMRADIUS_TRUNCATED_CUBOCTAHEDRON = sqrt(13 + 6 * sqrt(2)) / 2;

// Source: https://en.wikipedia.org/wiki/Snub_cube
// TODO: mirror image
CONSTANT_SNUB_CUBE = let (beta = pow(26 + 6 * sqrt(33), 1/3)) sqrt(4 / 3 - 16 / (3 * beta) + 2 * beta / 3);
VERTICES_SNUB_CUBE = [ // for the even mirror image.
	// even permutations
	[+1, +1/TRIBONACCI, -TRIBONACCI],  //0
	[+1, -1/TRIBONACCI, +TRIBONACCI],  //1
	[-1, +1/TRIBONACCI, +TRIBONACCI],  //2
	[-1, -1/TRIBONACCI, -TRIBONACCI],  //3

	[-TRIBONACCI, +1, +1/TRIBONACCI],  //4
	[+TRIBONACCI, -1, +1/TRIBONACCI],  //5
	[+TRIBONACCI, +1, -1/TRIBONACCI],  //6
	[-TRIBONACCI, -1, -1/TRIBONACCI],  //7

	[+1/TRIBONACCI, -TRIBONACCI, +1],  //8
	[-1/TRIBONACCI, +TRIBONACCI, +1],  //9
	[+1/TRIBONACCI, +TRIBONACCI, -1],  //10
	[-1/TRIBONACCI, -TRIBONACCI, -1],  //11
	
	// odd permutations
	[+TRIBONACCI, +1/TRIBONACCI, +1],  //12
	[+TRIBONACCI, -1/TRIBONACCI, -1],  //13
	[-TRIBONACCI, +1/TRIBONACCI, -1],  //14
	[-TRIBONACCI, -1/TRIBONACCI, +1],  //15
	
	[+1/TRIBONACCI, +1, +TRIBONACCI],  //16
	[-1/TRIBONACCI, +1, -TRIBONACCI],  //17
	[+1/TRIBONACCI, -1, -TRIBONACCI],  //18
	[-1/TRIBONACCI, -1, +TRIBONACCI],  //19
	
	[+1, +TRIBONACCI, +1/TRIBONACCI],  //20
	[+1, -TRIBONACCI, -1/TRIBONACCI],  //21
	[-1, -TRIBONACCI, +1/TRIBONACCI],  //22
	[-1, +TRIBONACCI, -1/TRIBONACCI]   //23
] / CONSTANT_SNUB_CUBE;
FACES_SNUB_CUBE = [
	[2, 16, 1, 19], [0, 17, 3, 18], [23, 10, 20, 9], [22, 8, 21, 11], [12, 6, 13, 5], [4, 15, 7, 14],
	
	[19, 1, 8], [19, 8, 22], [15, 19, 22], [15, 22, 7], [2, 19, 15], [2, 15, 4], [2, 4, 9], [16, 2, 9], [16, 9, 20], [16, 20, 12], [16, 12, 1], [1, 12, 5], [1, 5, 8], [9, 4, 23], [4, 14, 23], [12, 20, 6], [20, 10, 6], [8, 5, 21], [5, 13, 21], [22, 11, 7], [21, 13, 18], [13, 0, 18], [13, 6, 0], [6, 10, 0], [10, 17, 0], [10, 23, 17], [23, 14, 17], [14, 3, 17], [14, 7, 3], [7, 11, 3], [11, 18, 3], [11, 21, 18]
];
CIRCUMRADIUS_SNUB_CUBE = sqrt((3 - TRIBONACCI) / (8 - 4 * TRIBONACCI));

// Source: https://en.wikipedia.org/wiki/Icosidodecahedron
VERTICES_ICOSIDODECAHEDRON = [
	[0, 0, +2 * PHI],  //0
	[0, 0, -2 * PHI],  //1
	[0, +2 * PHI, 0],  //2
	[0, -2 * PHI, 0],  //3
	[+2 * PHI, 0, 0],  //4
	[-2 * PHI, 0, 0],  //5

	[+1, +PHI, +PHI*PHI],  //6
	[+1, +PHI, -PHI*PHI],  //7
	[+1, -PHI, +PHI*PHI],  //8
	[+1, -PHI, -PHI*PHI],  //9
	[-1, +PHI, +PHI*PHI],  //10
	[-1, +PHI, -PHI*PHI],  //11
	[-1, -PHI, +PHI*PHI],  //12
	[-1, -PHI, -PHI*PHI],  //13

	[+PHI, +PHI*PHI, +1],  //14
	[+PHI, +PHI*PHI, -1],  //15
	[+PHI, -PHI*PHI, +1],  //16
	[+PHI, -PHI*PHI, -1],  //17
	[-PHI, +PHI*PHI, +1],  //18
	[-PHI, +PHI*PHI, -1],  //19
	[-PHI, -PHI*PHI, +1],  //20
	[-PHI, -PHI*PHI, -1],  //21

	[+PHI*PHI, +1, +PHI],  //22
	[+PHI*PHI, +1, -PHI],  //23
	[+PHI*PHI, -1, +PHI],  //24
	[+PHI*PHI, -1, -PHI],  //25
	[-PHI*PHI, +1, +PHI],  //26
	[-PHI*PHI, +1, -PHI],  //27
	[-PHI*PHI, -1, +PHI],  //28
	[-PHI*PHI, -1, -PHI]   //29
] / 2;
FACES_ICOSIDODECAHEDRON = [
	[6, 0, 10], [0, 8, 12], [2, 15, 14], [2, 18, 19],
	[4, 24, 22], [4, 23, 25], [1, 13, 9], [1, 7, 11],
	[3, 16, 17], [3, 21, 20], [5, 26, 28], [5, 29, 27],
	
	[6, 14, 22], [7, 23, 15], [8, 24, 16], [9, 17, 25],
	[10, 26, 18], [11, 19, 27], [12, 20, 28], [13, 29, 21],
	
	[0, 6, 22, 24, 8], [0, 12, 28, 26, 10], [2, 14, 6, 10, 18], [2, 19, 11, 7, 15],
	[4, 22, 14, 15, 23], [4, 25, 17, 16, 24], [1, 9, 25, 23, 7], [1, 11, 27, 29, 13],
	[3, 20, 12, 8, 16], [3, 17, 9, 13, 21], [5, 27, 19, 18, 26], [5, 28, 20, 21, 29]
];
CIRCUMRADIUS_ICOSIDODECAHEDRON = PHI;

// Source: https://en.wikipedia.org/wiki/Truncated_dodecahedron
VERTICES_TRUNCATED_DODECAHEDRON = [
	[0, +1/PHI, +(2+PHI)],  //0
	[0, +1/PHI, -(2+PHI)],  //1
	[0, -1/PHI, +(2+PHI)],  //2
	[0, -1/PHI, -(2+PHI)],  //3
	
	[+(2+PHI), 0, +1/PHI],  //4
	[+(2+PHI), 0, -1/PHI],  //5
	[-(2+PHI), 0, +1/PHI],  //6
	[-(2+PHI), 0, -1/PHI],  //7
	
	[+1/PHI, +(2+PHI), 0],  //8	
	[+1/PHI, -(2+PHI), 0],  //9	
	[-1/PHI, +(2+PHI), 0],  //10	
	[-1/PHI, -(2+PHI), 0],  //11
	
	[+1/PHI, +PHI, +2*PHI],  //12
	[+1/PHI, +PHI, -2*PHI],  //13
	[+1/PHI, -PHI, +2*PHI],  //14
	[+1/PHI, -PHI, -2*PHI],  //15
	[-1/PHI, +PHI, +2*PHI],  //16
	[-1/PHI, +PHI, -2*PHI],  //17
	[-1/PHI, -PHI, +2*PHI],  //18
	[-1/PHI, -PHI, -2*PHI],  //19
	
	[+2*PHI, +1/PHI, +PHI],  //20
	[+2*PHI, +1/PHI, -PHI],  //21
	[+2*PHI, -1/PHI, +PHI],  //22
	[+2*PHI, -1/PHI, -PHI],  //23
	[-2*PHI, +1/PHI, +PHI],  //24
	[-2*PHI, +1/PHI, -PHI],  //25
	[-2*PHI, -1/PHI, +PHI],  //26
	[-2*PHI, -1/PHI, -PHI],  //27
	
	[+PHI, +2*PHI, +1/PHI],  //28
	[+PHI, +2*PHI, -1/PHI],  //29
	[+PHI, -2*PHI, +1/PHI],  //30
	[+PHI, -2*PHI, -1/PHI],  //31
	[-PHI, +2*PHI, +1/PHI],  //32
	[-PHI, +2*PHI, -1/PHI],  //33
	[-PHI, -2*PHI, +1/PHI],  //34
	[-PHI, -2*PHI, -1/PHI],  //35
	
	[+PHI, +2, +(PHI+1)], //36
	[+PHI, +2, -(PHI+1)], //37
	[+PHI, -2, +(PHI+1)], //38
	[+PHI, -2, -(PHI+1)], //39
	[-PHI, +2, +(PHI+1)], //40
	[-PHI, +2, -(PHI+1)], //41
	[-PHI, -2, +(PHI+1)], //42
	[-PHI, -2, -(PHI+1)], //43
	
	[+(PHI+1), +PHI, +2], //44
	[+(PHI+1), +PHI, -2], //45
	[+(PHI+1), -PHI, +2], //46
	[+(PHI+1), -PHI, -2], //47
	[-(PHI+1), +PHI, +2], //48
	[-(PHI+1), +PHI, -2], //49
	[-(PHI+1), -PHI, +2], //50
	[-(PHI+1), -PHI, -2], //51
	
	[+2, +(PHI+1), +PHI], //52
	[+2, +(PHI+1), -PHI], //53
	[+2, -(PHI+1), +PHI], //54
	[+2, -(PHI+1), -PHI], //55
	[-2, +(PHI+1), +PHI], //56
	[-2, +(PHI+1), -PHI], //57
	[-2, -(PHI+1), +PHI], //58
	[-2, -(PHI+1), -PHI]  //59
] / (2 * PHI - 2);
FACES_TRUNCATED_DODECAHEDRON = [
	[2, 0, 12, 36, 44, 20, 22, 46, 38, 14], [2, 18, 42, 50, 26, 24, 48, 40, 16, 0],
[1, 3, 15, 39, 47, 23, 21, 45, 37, 13], [3, 1, 17, 41, 49, 25, 27, 51, 43, 19], [35, 11, 9, 31, 55, 39, 15, 19, 43, 59], [26, 50, 58, 34, 35, 59, 51, 27, 7, 6], [8, 10, 33, 57, 41, 17, 13, 37, 53, 29], [48, 24, 6, 7, 25, 49, 57, 33, 32, 56], [12, 16, 40, 56, 32, 10, 8, 28, 52, 36], [4, 20, 44, 52, 28, 29, 53, 45, 21, 5], [46, 22, 4, 5, 23, 47, 55, 31, 30, 54], [18, 14, 38, 54, 30, 9, 11, 34, 58, 42],

	[2, 14, 18], [0, 16, 12], [6, 24, 26], [40, 48, 56], [44, 36, 52], [20, 4, 22], [5, 21, 23], [38, 46, 54], [50, 42, 58], [34, 11, 35], [51, 59, 43], [7, 27, 25], [57, 49, 41], [32, 33, 10], [28, 8, 29], [53, 37, 45], [30, 31, 9], [55, 47, 39], [15, 3, 19], [13, 17, 1]
];
CIRCUMRADIUS_TRUNCATED_DODECAHEDRON = sqrt(74 + 30 * sqrt(5)) / 4;

// Source: https://en.wikipedia.org/wiki/Truncated_icosahedron
VERTICES_TRUNCATED_ICOSAHEDRON = [
	[0, +1, +3*PHI],  //0
	[0, +1, -3*PHI],  //1
	[0, -1, +3*PHI],  //2
	[0, -1, -3*PHI],  //3

	[+1, +3*PHI, 0],  //4
	[+1, -3*PHI, 0],  //5
	[-1, +3*PHI, 0],  //6
	[-1, -3*PHI, 0],  //7
	
	[+3*PHI, 0, +1],  //8
	[+3*PHI, 0, -1],  //9
	[-3*PHI, 0, +1],  //10
	[-3*PHI, 0, -1],  //11

	[+1, +(2+PHI), +2*PHI],  //12
	[+1, +(2+PHI), -2*PHI],  //13
	[+1, -(2+PHI), +2*PHI],  //14
	[+1, -(2+PHI), -2*PHI],  //15
	[-1, +(2+PHI), +2*PHI],  //16
	[-1, +(2+PHI), -2*PHI],  //17
	[-1, -(2+PHI), +2*PHI],  //18
	[-1, -(2+PHI), -2*PHI],  //19

	[+(2+PHI), +2*PHI, +1],  //20
	[+(2+PHI), +2*PHI, -1],  //21
	[+(2+PHI), -2*PHI, +1],  //22
	[+(2+PHI), -2*PHI, -1],  //23
	[-(2+PHI), +2*PHI, +1],  //24
	[-(2+PHI), +2*PHI, -1],  //25
	[-(2+PHI), -2*PHI, +1],  //26
	[-(2+PHI), -2*PHI, -1],  //27

	[+2*PHI, +1, +(2+PHI)],  //28
	[+2*PHI, +1, -(2+PHI)],  //29
	[+2*PHI, -1, +(2+PHI)],  //30
	[+2*PHI, -1, -(2+PHI)],  //31
	[-2*PHI, +1, +(2+PHI)],  //32
	[-2*PHI, +1, -(2+PHI)],  //33
	[-2*PHI, -1, +(2+PHI)],  //34
	[-2*PHI, -1, -(2+PHI)],  //35

	[+PHI, +2, +pow(PHI,3)],  //36
	[+PHI, +2, -pow(PHI,3)],  //37
	[+PHI, -2, +pow(PHI,3)],  //38
	[+PHI, -2, -pow(PHI,3)],  //39
	[-PHI, +2, +pow(PHI,3)],  //40
	[-PHI, +2, -pow(PHI,3)],  //41
	[-PHI, -2, +pow(PHI,3)],  //42
	[-PHI, -2, -pow(PHI,3)],  //43
	
	[+2, +pow(PHI,3), +PHI],  //44
	[+2, +pow(PHI,3), -PHI],  //45
	[+2, -pow(PHI,3), +PHI],  //46
	[+2, -pow(PHI,3), -PHI],  //47
	[-2, +pow(PHI,3), +PHI],  //48
	[-2, +pow(PHI,3), -PHI],  //49
	[-2, -pow(PHI,3), +PHI],  //50
	[-2, -pow(PHI,3), -PHI],  //51
	
	[+pow(PHI,3), +PHI, +2],  //52
	[+pow(PHI,3), +PHI, -2],  //53
	[+pow(PHI,3), -PHI, +2],  //54
	[+pow(PHI,3), -PHI, -2],  //55
	[-pow(PHI,3), +PHI, +2],  //56
	[-pow(PHI,3), +PHI, -2],  //57
	[-pow(PHI,3), -PHI, +2],  //58
	[-pow(PHI,3), -PHI, -2]   //59
] / 2;
FACES_TRUNCATED_ICOSAHEDRON = [
	[0, 2, 42, 34, 32, 40], [2, 0, 36, 28, 30, 38], [39, 31, 29, 37, 1, 3], [41, 33, 35, 43, 3, 1], [28, 36, 12, 44, 20, 52], [38, 30, 54, 22, 46, 14], [34, 42, 18, 50, 26, 58], [40, 32, 56, 24, 48, 16], [12, 16, 48, 6, 4, 44], [18, 14, 46, 5, 7, 50], [52, 20, 21, 53, 9, 8], [54, 8, 9, 55, 23, 22], [7, 5, 47, 15, 19, 51], [27, 51, 19, 43, 35, 59], [58, 26, 27, 59, 11, 10], [24, 56, 10, 11, 57, 25], [4, 6, 49, 17, 13, 45], [21, 45, 13, 37, 29, 53], [23, 55, 31, 39, 15, 47], [17, 49, 25, 57, 33, 41],

	[0, 40, 16, 12, 36], [2, 38, 14, 18, 42], [30, 28, 52, 8, 54], [32, 34, 58, 10, 56], [43, 19, 15, 39, 3], [1, 37, 13, 17, 41], [55, 9, 53, 29, 31], [57, 11, 59, 35, 33], [48, 24, 25, 49, 6], [44, 4, 45, 21, 20], [46, 22, 23, 47, 5], [27, 26, 50, 7, 51]
];
CIRCUMRADIUS_TRUNCATED_ICOSAHEDRON = sqrt(9 * PHI + 10) / 2;

// Source: https://en.wikipedia.org/wiki/Rhombicosidodecahedron
VERTICES_RHOMBICOSIDODECAHEDRON =
[
	[+1/2, +1/2, +pow(PHI,3)/2],  //0
	[+1/2, +1/2, -pow(PHI,3)/2],  //1
	[+1/2, -1/2, +pow(PHI,3)/2],  //2
	[+1/2, -1/2, -pow(PHI,3)/2],  //3
	[-1/2, +1/2, +pow(PHI,3)/2],  //4
	[-1/2, +1/2, -pow(PHI,3)/2],  //5
	[-1/2, -1/2, +pow(PHI,3)/2],  //6
	[-1/2, -1/2, -pow(PHI,3)/2],  //7
	
	[+1/2, +pow(PHI,3)/2, +1/2],  //8
	[+1/2, +pow(PHI,3)/2, -1/2],  //9
	[+1/2, -pow(PHI,3)/2, +1/2],  //10
	[+1/2, -pow(PHI,3)/2, -1/2],  //11
	[-1/2, +pow(PHI,3)/2, +1/2],  //12
	[-1/2, +pow(PHI,3)/2, -1/2],  //13
	[-1/2, -pow(PHI,3)/2, +1/2],  //14
	[-1/2, -pow(PHI,3)/2, -1/2],  //15
	
	[+pow(PHI,3)/2, +1/2, +1/2],  //16
	[+pow(PHI,3)/2, +1/2, -1/2],  //17
	[+pow(PHI,3)/2, -1/2, +1/2],  //18
	[+pow(PHI,3)/2, -1/2, -1/2],  //19
	[-pow(PHI,3)/2, +1/2, +1/2],  //20
	[-pow(PHI,3)/2, +1/2, -1/2],  //21
	[-pow(PHI,3)/2, -1/2, +1/2],  //22
	[-pow(PHI,3)/2, -1/2, -1/2],  //23
	
	[+pow(PHI,2)/2, +PHI/2, +PHI],  //24
	[+pow(PHI,2)/2, +PHI/2, -PHI],  //25
	[+pow(PHI,2)/2, -PHI/2, +PHI],  //26
	[+pow(PHI,2)/2, -PHI/2, -PHI],  //27
	[-pow(PHI,2)/2, +PHI/2, +PHI],  //28
	[-pow(PHI,2)/2, +PHI/2, -PHI],  //29
	[-pow(PHI,2)/2, -PHI/2, +PHI],  //30
	[-pow(PHI,2)/2, -PHI/2, -PHI],  //31
	
	[+PHI, +pow(PHI,2)/2, +PHI/2],  //32
	[+PHI, +pow(PHI,2)/2, -PHI/2],  //33
	[+PHI, -pow(PHI,2)/2, +PHI/2],  //34
	[+PHI, -pow(PHI,2)/2, -PHI/2],  //35
	[-PHI, +pow(PHI,2)/2, +PHI/2],  //36
	[-PHI, +pow(PHI,2)/2, -PHI/2],  //37
	[-PHI, -pow(PHI,2)/2, +PHI/2],  //38
	[-PHI, -pow(PHI,2)/2, -PHI/2],  //39
	
	[+PHI/2, +PHI, +pow(PHI,2)/2],  //40
	[+PHI/2, +PHI, -pow(PHI,2)/2],  //41
	[+PHI/2, -PHI, +pow(PHI,2)/2],  //42
	[+PHI/2, -PHI, -pow(PHI,2)/2],  //43
	[-PHI/2, +PHI, +pow(PHI,2)/2],  //44
	[-PHI/2, +PHI, -pow(PHI,2)/2],  //45
	[-PHI/2, -PHI, +pow(PHI,2)/2],  //46
	[-PHI/2, -PHI, -pow(PHI,2)/2],  //47
	
	[+(1+PHI/2), 0, +pow(PHI,2)/2],  //48
	[+(1+PHI/2), 0, -pow(PHI,2)/2],  //49
	[-(1+PHI/2), 0, +pow(PHI,2)/2],  //50
	[-(1+PHI/2), 0, -pow(PHI,2)/2],  //51
	
	[+pow(PHI,2)/2, +(1+PHI/2), 0],  //52
	[+pow(PHI,2)/2, -(1+PHI/2), 0],  //53
	[-pow(PHI,2)/2, +(1+PHI/2), 0],  //54
	[-pow(PHI,2)/2, -(1+PHI/2), 0],  //55
	
	[0, +pow(PHI,2)/2, +(1+PHI/2)],  //56
	[0, +pow(PHI,2)/2, -(1+PHI/2)],  //57
	[0, -pow(PHI,2)/2, +(1+PHI/2)],  //58
	[0, -pow(PHI,2)/2, -(1+PHI/2)],  //59
];
FACES_RHOMBICOSIDODECAHEDRON = 
[
	[50, 28, 4, 6, 30], [37, 54, 36, 20, 21], [22, 38, 55, 39, 23], [0, 24, 48, 26, 2], [44, 12, 8, 40, 56], [46, 58, 42, 10, 14], [53, 34, 18, 19, 35], [32, 52, 33, 17, 16], [9, 13, 45, 57, 41], [51, 31, 7, 5, 29], [15, 11, 43, 59, 47], 
	
	[0, 2, 6, 4], [2, 26, 42, 58], [6, 58, 46, 30], [38, 46, 14, 55], [50, 30, 38, 22], [49, 25, 1, 3, 27], [20, 22, 23, 21], [28, 50, 20, 36], [56, 4, 28, 44], [44, 36, 54, 12], [0, 56, 40, 24], [40, 8, 52, 32], [48, 24, 32, 16], [18, 16, 17, 19], [26, 48, 18, 34], [42, 34, 53, 10], [14, 10, 11, 15], [11, 53, 35, 43], [55, 15, 47, 39], [23, 39, 31, 51], [54, 37, 45, 13], [37, 21, 51, 29], [8, 12, 13, 9], [52, 9, 41, 33], [17, 33, 25, 49], [35, 19, 49, 27], [43, 27, 3, 59], [47, 59, 7, 31], [45, 29, 5, 57], [5, 7, 3, 1], [1, 25, 41, 57], 
	
	[0, 4, 56], [6, 2, 58], [30, 46, 38], [26, 34, 42], [10, 53, 11], [48, 16, 18], [24, 40, 32], [52, 8, 9], [12, 54, 13], [44, 28, 36], [50, 22, 20], [21, 23, 51], [55, 14, 15], [35, 27, 43], [19, 17, 49], [33, 41, 25], [57, 5, 1], [3, 7, 59], [47, 31, 39], [45, 37, 29]
];
CIRCUMRADIUS_RHOMBICOSIDODECAHEDRON = sqrt(8 * PHI + 7) / 2;

// Source: https://en.wikipedia.org/wiki/Truncated_icosidodecahedron
VERTICES_TRUNCATED_ICOSIDODECAHEDRON =
[
	[+1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2)],
	[+1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2)],
	[+1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2)],
	[+1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2)],
	
	[+(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI)],
	[+(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI)],
	[+(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI)],
	[+(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI)],
	[-(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI)],
	[-(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI)],
	[-(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI), +1/((2*PHI-2)*PHI)],
	[-(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI), -1/((2*PHI-2)*PHI)],
	
	[+1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[+1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	[+1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[+1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	[-1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[-1/((2*PHI-2)*PHI), +(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	[-1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[-1/((2*PHI-2)*PHI), -(3+PHI)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	
	[+1/((PHI-1)*PHI), +PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2)],
	[+1/((PHI-1)*PHI), +PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2)],
	[+1/((PHI-1)*PHI), -PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2)],
	[+1/((PHI-1)*PHI), -PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2)],
	[-1/((PHI-1)*PHI), +PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2)],
	[-1/((PHI-1)*PHI), +PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2)],
	[-1/((PHI-1)*PHI), -PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2)],
	[-1/((PHI-1)*PHI), -PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2)],
	
	[+(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI), +PHI/(2*PHI-2)],
	[+(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI), -PHI/(2*PHI-2)],
	[+(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI), +PHI/(2*PHI-2)],
	[+(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI), -PHI/(2*PHI-2)],
	[-(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI), +PHI/(2*PHI-2)],
	[-(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI), -PHI/(2*PHI-2)],
	[-(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI), +PHI/(2*PHI-2)],
	[-(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI), -PHI/(2*PHI-2)],
	
	[+PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI)],
	[+PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI)],
	[+PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI)],
	[+PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI)],
	[-PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI)],
	[-PHI/(2*PHI-2), +(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI)],
	[-PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2), +1/((PHI-1)*PHI)],
	[-PHI/(2*PHI-2), -(1+2*PHI)/(2*PHI-2), -1/((PHI-1)*PHI)],
	
	[+1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2)],
	[+1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2)],
	[+1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2)],
	[+1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2)],
	[-1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2)],
	
	[+(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2)],
	[+(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2)],
	[+(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2)],
	[+(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2)],
	[-(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2)],
	[-(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2)],
	[-(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI), +PHI*PHI/(2*PHI-2)],
	[-(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI), -PHI*PHI/(2*PHI-2)],
	
	[+PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[+PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	[+PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[+PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	[-PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[-PHI*PHI/(2*PHI-2), +(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	[-PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2), +1/((2*PHI-2)*PHI)],
	[-PHI*PHI/(2*PHI-2), -(3*PHI-1)/(2*PHI-2), -1/((2*PHI-2)*PHI)],
	
	[+(2*PHI-1)/(2*PHI-2), +1/(PHI-1), +(2+PHI)/(2*PHI-2)],
	[+(2*PHI-1)/(2*PHI-2), +1/(PHI-1), -(2+PHI)/(2*PHI-2)],
	[+(2*PHI-1)/(2*PHI-2), -1/(PHI-1), +(2+PHI)/(2*PHI-2)],
	[+(2*PHI-1)/(2*PHI-2), -1/(PHI-1), -(2+PHI)/(2*PHI-2)],
	[-(2*PHI-1)/(2*PHI-2), +1/(PHI-1), +(2+PHI)/(2*PHI-2)],
	[-(2*PHI-1)/(2*PHI-2), +1/(PHI-1), -(2+PHI)/(2*PHI-2)],
	[-(2*PHI-1)/(2*PHI-2), -1/(PHI-1), +(2+PHI)/(2*PHI-2)],
	[-(2*PHI-1)/(2*PHI-2), -1/(PHI-1), -(2+PHI)/(2*PHI-2)],
	
	[+(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2), +1/(PHI-1)],
	[+(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2), -1/(PHI-1)],
	[+(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2), +1/(PHI-1)],
	[+(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2), -1/(PHI-1)],
	[-(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2), +1/(PHI-1)],
	[-(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2), -1/(PHI-1)],
	[-(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2), +1/(PHI-1)],
	[-(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2), -1/(PHI-1)],
	
	[+1/(PHI-1), +(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2)],
	[+1/(PHI-1), +(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2)],
	[+1/(PHI-1), -(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2)],
	[+1/(PHI-1), -(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2)],
	[-1/(PHI-1), +(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2)],
	[-1/(PHI-1), +(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2)],
	[-1/(PHI-1), -(2+PHI)/(2*PHI-2), +(2*PHI-1)/(2*PHI-2)],
	[-1/(PHI-1), -(2+PHI)/(2*PHI-2), -(2*PHI-1)/(2*PHI-2)],
	
	[+PHI/(2*PHI-2), +3/(2*PHI-2), +PHI/(PHI-1)],
	[+PHI/(2*PHI-2), +3/(2*PHI-2), -PHI/(PHI-1)],
	[+PHI/(2*PHI-2), -3/(2*PHI-2), +PHI/(PHI-1)],
	[+PHI/(2*PHI-2), -3/(2*PHI-2), -PHI/(PHI-1)],
	[-PHI/(2*PHI-2), +3/(2*PHI-2), +PHI/(PHI-1)],
	[-PHI/(2*PHI-2), +3/(2*PHI-2), -PHI/(PHI-1)],
	[-PHI/(2*PHI-2), -3/(2*PHI-2), +PHI/(PHI-1)],
	[-PHI/(2*PHI-2), -3/(2*PHI-2), -PHI/(PHI-1)],
	
	[+PHI/(PHI-1), +PHI/(2*PHI-2), +3/(2*PHI-2)],
	[+PHI/(PHI-1), +PHI/(2*PHI-2), -3/(2*PHI-2)],
	[+PHI/(PHI-1), -PHI/(2*PHI-2), +3/(2*PHI-2)],
	[+PHI/(PHI-1), -PHI/(2*PHI-2), -3/(2*PHI-2)],
	[-PHI/(PHI-1), +PHI/(2*PHI-2), +3/(2*PHI-2)],
	[-PHI/(PHI-1), +PHI/(2*PHI-2), -3/(2*PHI-2)],
	[-PHI/(PHI-1), -PHI/(2*PHI-2), +3/(2*PHI-2)],
	[-PHI/(PHI-1), -PHI/(2*PHI-2), -3/(2*PHI-2)],
	
	[+3/(2*PHI-2), +PHI/(PHI-1), +PHI/(2*PHI-2)],
	[+3/(2*PHI-2), +PHI/(PHI-1), -PHI/(2*PHI-2)],
	[+3/(2*PHI-2), -PHI/(PHI-1), +PHI/(2*PHI-2)],
	[+3/(2*PHI-2), -PHI/(PHI-1), -PHI/(2*PHI-2)],
	[-3/(2*PHI-2), +PHI/(PHI-1), +PHI/(2*PHI-2)],
	[-3/(2*PHI-2), +PHI/(PHI-1), -PHI/(2*PHI-2)],
	[-3/(2*PHI-2), -PHI/(PHI-1), +PHI/(2*PHI-2)],
	[-3/(2*PHI-2), -PHI/(PHI-1), -PHI/(2*PHI-2)]
];
FACES_TRUNCATED_ICOSIDODECAHEDRON = 
[
	[2, 0, 24, 72, 104, 56, 58, 106, 74, 26], [4, 6, 30, 78, 110, 62, 60, 108, 76, 28], [48, 52, 100, 92, 44, 20, 16, 40, 88, 96], [84, 36, 12, 13, 37, 85, 117, 69, 68, 116], [38, 86, 118, 70, 71, 119, 87, 39, 15, 14], [54, 50, 98, 90, 42, 18, 22, 46, 94, 102], [82, 34, 10, 11, 35, 83, 115, 67, 66, 114], [80, 112, 64, 65, 113, 81, 33, 9, 8, 32], [17, 21, 45, 93, 101, 53, 49, 97, 89, 41], [61, 63, 111, 79, 31, 7, 5, 29, 77, 109], [23, 19, 43, 91, 99, 51, 55, 103, 95, 47], [57, 105, 73, 25, 1, 3, 27, 75, 107, 59],
	
	[6, 2, 26, 50, 54, 30], [74, 106, 82, 114, 90, 98], [42, 66, 67, 43, 19, 18], [110, 78, 102, 94, 118, 86], [70, 46, 22, 23, 47, 71], [60, 62, 38, 14, 12, 36], [0, 4, 28, 52, 48, 24], [100, 76, 108, 84, 116, 92], [104, 72, 96, 88, 112, 80], [58, 56, 32, 8, 10, 34], [13, 15, 39, 63, 61, 37], [87, 119, 95, 103, 79, 111], [115, 83, 107, 75, 99, 91], [11, 9, 33, 57, 59, 35], [64, 40, 16, 17, 41, 65], [20, 44, 68, 69, 45, 21], [117, 85, 109, 77, 101, 93], [53, 29, 5, 1, 25, 49], [7, 31, 55, 51, 27, 3], [113, 89, 97, 73, 105, 81], 
	
	[4, 0, 2, 6], [20, 21, 17, 16], [12, 14, 15, 13], [22, 18, 19, 23], [10, 8, 9, 11], [1, 5, 7, 3], [24, 48, 96, 72], [92, 116, 68, 44], [84, 108, 60, 36], [100, 52, 28, 76], [30, 54, 102, 78], [90, 114, 66, 42], [106, 58, 34, 82], [56, 104, 80, 32], [88, 40, 64, 112], [65, 41, 89, 113], [33, 81, 105, 57], [35, 59, 107, 83], [67, 115, 91, 43], [75, 27, 51, 99], [118, 94, 46, 70], [71, 47, 95, 119], [69, 117,93, 45], [62, 110, 86, 38], [26, 74, 98, 50], [97, 49, 25, 73], [101, 77, 29, 53], [85, 37, 61, 109], [39, 87, 111, 63], [103, 55, 31, 79]
];
CIRCUMRADIUS_TRUNCATED_ICOSIDODECAHEDRON = sqrt(31 + 12 * sqrt(5)) / 2;

// Source: https://en.wikipedia.org/wiki/Snub_dodecahedron
// Source: https://mathworld.wolfram.com/SnubDodecahedron.html
// TODO: mirror image
VERTICES_SNUB_DODECAHEDRON =
[
	[-2.050215876504471, -0.643029605914073, +0.175392626961585],  //0
	[+2.050215876504471, -0.643029605914073, -0.175392626961585],  //1
	[-1.645069107445494, +0.643029605914073, +1.236080638790192],  //2
	[+1.645069107445494, +0.643029605914073, -1.236080638790192],  //3
	[-2.092754375489906, +0.330921024729844, +0.398127099310126],  //4
	[+2.092754375489906, +0.330921024729844, -0.398127099310126],  //5
	[-1.332963201807377, +1.646917940690374, -0.398127099310126],  //6
	[+1.332963201807377, +1.646917940690374, +0.398127099310126],  //7
	[-1.825265080808600, -0.330921024729844, +1.098423164412520],  //8
	[+1.825265080808600, -0.330921024729844, -1.098423164412520],  //9
	[-0.626046526341877, +1.746186440985826, -1.098423164412520],  //10
	[+0.626046526341877, +1.746186440985826, +1.098423164412520],  //11
	[-1.062215752565082, +1.454024229338015, +1.185388553785668],  //12
	[+1.062215752565082, +1.454024229338015, -1.185388553785668],  //13
	[-1.932135944910516, +0.847550046789061, -0.442881921642891],  //14
	[+1.932135944910516, +0.847550046789061, +0.442881921642891],  //15
	[-1.144874490434974, -0.847550046789061, +1.618195324206757],  //16
	[+1.144874490434974, -0.847550046789061, -1.618195324206757],  //17
	[-1.581987912359319, -1.454024229338015, -0.175392626961585],  //18
	[+1.581987912359319, -1.454024229338015, +0.175392626961585],  //19
	[-1.057412406163561, +0.374821658114562, -1.840929796555298],  //20
	[+1.057412406163561, +0.374821658114562, +1.840929796555298],  //21
	[-0.439137857559085, -0.374821658114562, -2.077089659743209],  //22
	[+0.439137857559085, -0.374821658114562, +2.077089659743209],  //23
	[-1.562410369575602, -1.249503788463027, +0.803273868369103],  //24
	[+1.562410369575602, -1.249503788463027, -0.803273868369103],  //25
	[-1.863307207721680, -0.728335176957191, -0.803273868369103],  //26
	[+1.863307207721680, -0.728335176957191, +0.803273868369103],  //27
	[-1.700067843953274, +1.249503788463027, +0.442881921642891],  //28
	[+1.700067843953274, +1.249503788463027, -0.442881921642891],  //29
	[-0.728114044042271, -1.646917940690374, +1.185388553785668],  //30
	[+0.728114044042271, -1.646917940690374, -1.185388553785668],  //31
	[-0.265654579615664, -1.746186440985826, -1.236080638790192],  //32
	[+0.265654579615664, -1.746186440985826, +1.236080638790192],  //33
	[-0.759791173682529, -1.977838965420219, -0.398127099310126],  //34
	[+0.759791173682529, -1.977838965420219, +0.398127099310126],  //35
	[-1.199218554466724, -1.415265416255982, -1.098423164412520],  //36
	[+1.199218554466724, -1.415265416255982, +1.098423164412520],  //37
	[-1.790329796607353, +0.192893711352359, -1.185388553785668],  //38
	[+1.790329796607353, +0.192893711352359, +1.185388553785668],  //39
	[-1.306437116715503, -0.567715369466921, -1.618195324206757],  //40
	[+1.306437116715503, -0.567715369466921, +1.618195324206757],  //41
	[-0.853311280897597, +0.728335176957191, +1.840929796555298],  //42
	[+0.853311280897597, +0.728335176957191, -1.840929796555298],  //43
	[-1.379414527829830, +1.103156835071754, -1.236080638790192],  //44
	[+1.379414527829830, +1.103156835071754, +1.236080638790192],  //45
	[-0.105036149036274, +0.567715369466921, -2.077089659743209],  //46
	[+0.105036149036274, +0.567715369466921, +2.077089659743209],  //47
	[-0.468227964145153, +2.097053835252088, -0.175392626961585],  //48
	[+0.468227964145153, +2.097053835252088, +0.175392626961585],  //49
	[-0.300896838146078, +1.977838965420219, +0.803273868369103],  //50
	[+0.300896838146078, +1.977838965420219, -0.803273868369103],  //51
	[-0.161562626280529, +1.415265416255982, +1.618195324206757],  //52
	[+0.161562626280529, +1.415265416255982, -1.618195324206757],  //53
	[-0.544174006595359, -0.192893711352359, +2.077089659743209],  //54
	[+0.544174006595359, -0.192893711352359, -2.077089659743209],  //55
	[-0.232068100957242, -2.097053835252088, +0.442881921642891],  //56
	[+0.232068100957242, -2.097053835252088, -0.442881921642891],  //57
	[-0.204101125265964, -1.103156835071754, +1.840929796555298],  //58
	[+0.204101125265964, -1.103156835071754, -1.840929796555298]   //59
];
FACES_SNUB_DODECAHEDRON = 
[
	[19, 25, 31, 57, 35], [24, 30, 56, 34, 18], [23, 41, 37, 33, 58], [27, 39, 15, 5, 1], [17, 9, 3, 43, 55], [32, 59, 22, 40, 36], [21, 47, 52, 11, 45], [16, 8, 2, 42, 54], [38, 14, 4, 0, 26], [10, 44, 20, 46, 53], [7, 49, 51, 13, 29], [12, 28, 6, 48, 50],
	
	[35, 57, 56], [33, 35, 56], [35, 33, 37], [37, 19, 35], [37, 27, 19], [27, 1, 19], [1, 25, 19], [1, 9, 25], [9, 17, 25], [25, 17, 31], [17, 59, 31], [31, 32, 57], [31, 59, 32], [32, 34, 57], [57, 34, 56], [41, 27, 37], [41, 39, 27], [23, 21, 41], [21, 39, 41], [21, 45, 39], [47, 21, 23], [23, 54, 47], [58, 54, 23], [16, 54, 58], [16, 58, 30], [58, 33, 30], [33, 56, 30], [16, 30, 24], [8, 16, 24], [8, 24, 0], [0, 24, 18], [0, 18, 26], [26, 18, 36], [18, 34, 36], [34, 32, 36], [26, 36, 40], [38, 26, 40], [38, 40, 20], [20, 40, 22], [20, 22, 46], [46, 22, 55], [22, 59, 55], [59, 17, 55], [1, 5, 9], [5, 3, 9], [15, 29, 5], [5, 29, 3], [3, 29, 13], [3, 13, 43], [13, 53, 43], [43, 46, 55], [43, 53, 46], [39, 45, 15], [45, 7, 15], [15, 7, 29], [47, 54, 42], [47, 42, 52], [52, 42, 12], [42, 2, 12], [2, 28, 12], [2, 8, 4], [8, 0, 4], [2, 4, 28], [28, 4, 14], [6, 28, 14], [45, 11, 7], [7, 11, 49], [11, 52, 50], [50, 52, 12], [11, 50, 49], [49, 50, 48], [49, 48, 51], [13, 51, 53], [51, 10, 53], [51, 48, 10], [48, 6, 10], [10, 6, 44], [6, 14, 44], [14, 38, 44], [44, 38, 20]
];
CIRCUMRADIUS_SNUB_DODECAHEDRON = 2.155837375115640;


///////////////////////////////////
// Data: Regular N-gon Polyhedra //
///////////////////////////////////

// Source: https://en.wikipedia.org/wiki/Prism_(geometry)
function VERTICES_PRISM(n = 5) = 
	let (
		r = 1 / (2 * sin(180 / n))
	)
	[for (k = [0 : 2 * n - 1]) [r * cos(360 * floor(k / 2) / n), r * sin(360 * floor(k / 2) / n), pow(-1, k) * 1 / 2]];
function FACES_PRISM(n = 5) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces = [for (k = [0 : n - 1]) [for (l = [1, 0, 2, 3]) (l + 2 * k) % (2 * n)]]
	) 
	concat([top_face, bottom_face], side_faces);
function CIRCUMRADIUS_PRISM(n = 5) = 1 / sin(atan(sin(180 / n))) / 2;
		
// Source: https://en.wikipedia.org/wiki/Antiprism
function VERTICES_ANTIPRISM(n = 5) =
	let (
		r = 1 / (2 * sin(180 / n)),
		h = sqrt((cos(180 / n) - cos(360 / n)) / 2)
	)
	[for (k = [0 : 2 * n - 1]) [r * cos(180 * k / n), r * sin(180 * k / n), r * pow(-1, k) * h]];
function FACES_ANTIPRISM(n = 5) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces_top = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [2 : -1 : 0]) (l + k) % (2 * n)]],
		side_faces_bottom = [for (k = [1 : 2 : 2 * n - 1]) [for (l = [0 : 2]) (l + k) % (2 * n)]]	
	)
	concat([top_face, bottom_face], side_faces_top, side_faces_bottom);
function CIRCUMRADIUS_ANTIPRISM(n = 5) = 1 / 4 * sqrt(4 + 1 / pow(sin(90 / n), 2));
		
// Source: https://en.wikipedia.org/wiki/Trapezohedron
function VERTICES_TRAPEZOHEDRON(n = 5) =
	let (
		r = 1 / (2 * sin(180 / n)),
		o = 1 / 4,
		h = 1
	)
	concat([[0, 0, h], [0, 0, -h]], [for (k = [0 : 2 * n - 1]) [r * cos(180 * k / n), r * sin(180 * k / n), pow(-1, k) * o]]);
function FACES_TRAPEZOHEDRON(n = 5) = 
	let (
		c = 2 * n,
		top_faces = [for (k = [0 : n - 1]) [0, (2 + 2*k) % c + 2, 3 + 2*k, 2 + 2*k]],
		bottom_faces = [for (k = [0 : n - 1]) [1, 3 + 2*k, (2 + 2*k) % c + 2, (3 + 2*k) % c + 2]]
	)
	concat(top_faces, bottom_faces);
function CIRCUMRADIUS_TRAPEZOHEDRON(n = 5) = 1 / sin(atan(sin(180 / n))) / 2;
		
// Source: https://en.wikipedia.org/wiki/Prism_(geometry)#Star_prism
function VERTICES_STAR_PRISM(n = 5, m = 2) = 
	let (
		r = 1 / (2 * sin(180 / n)),
		vertices_top = [for (k = [0 : n - 1]) [r * cos(360 * k / n), r * sin(360 * k / n), 1 / 2]],
		vertices_bottom = [for (k = [0 : n - 1]) [r * cos(360 * k / n), r * sin(360 * k / n), -1 / 2]],
		vertices_star_top = [for (k = [0 : n - 1]) line_intersection(vertices_top[k], vertices_top[(k + m) % n], vertices_top[(k + 1) % n], vertices_top[mod_plus(k - m + 1, n)])],
		vertices_star_bottom = [for (k = [0 : n - 1]) line_intersection(vertices_bottom[k], vertices_bottom[(k + m) % n], vertices_bottom[(k + 1) % n], vertices_bottom[mod_plus(k - m + 1, n)])]
	)
	concat(vertices_top, vertices_bottom, vertices_star_top, vertices_star_bottom);
function FACES_STAR_PRISM(n = 5, m = 2) = 
	let (
		top_face = [for (k = [2 * n - 1 : - 1 : 0]) floor(k / 2) + 2 * n * (k % 2)],
		bottom_face = [for (k = [0 : 2 * n - 1]) n + floor(k / 2) + 2 * n * (k % 2)],
		side_faces = concat(
			[for (k = [0 : n - 1]) [for (l = [0, 2*n, 3*n, n]) (l + k)]],
			[for (k = [0 : n - 1]) [for (l = [0, n, 3*n-1+n*(1-ceil(k/n)), 2*n-1+n*(1-ceil(k/n))]) (l + k)]]	
		)
	) 
	concat([top_face, bottom_face], side_faces);
function CIRCUMRADIUS_STAR_PRISM(n = 5, m = 2) = 1 / sin(atan(sin(180 / n))) / 2;
		
// Source: https://en.wikipedia.org/wiki/Bipyramid#Star_bipyramids
function VERTICES_STAR_DIPYRAMID(n = 5, m = 2) =
	let (
		r = 1 / cos(180 / n),
		h = 1,
		vertices_poles = [[0, 0, h], [0, 0, -h]],
		vertices_ngon = [for (k = [0 : n - 1]) [r * cos(360 * k / n), r * sin(360 * k / n), 0]],
		vertices_star = [for (k = [0 : n - 1]) line_intersection(vertices_ngon[k], vertices_ngon[(k + m) % n], vertices_ngon[(k + 1) % n], vertices_ngon[mod_plus(k - m + 1, n)])]
	)
	concat(vertices_poles, vertices_ngon, vertices_star);
function FACES_STAR_DIPYRAMID(n = 5, m = 2) = 
	let (
		faces_top_forward = [for (k = [0 : n - 1]) [0, 2 + k, (n + 2) + (n + k - 1) % n]],
		faces_top_backward = [for (k = [0 : n - 1]) [0, (n + 2) + (n + k) % n, 2 + k]],
		faces_bottom_forward = [for (k = [0 : n - 1]) [1, (n + 2) + (n + k - 1) % n, 2 + k]],
		faces_bottom_backward = [for (k = [0 : n - 1]) [1, 2 + k, (n + 2) + (n + k) % n]]
	)
	concat(faces_top_forward, faces_top_backward, faces_bottom_forward, faces_bottom_backward);
function CIRCUMRADIUS_STAR_DIPYRAMID(n = 5, m = 2) = 1 / cos(180 / n);


//////////////////////////
// Data: Catalan Solids //
//////////////////////////	

// Source: https://en.wikipedia.org/wiki/Triakis_tetrahedron
VERTICES_TRIAKIS_TETRAHEDRON = [
	[0, 0, -5/(2*sqrt(6))],  //0
	[0, 0, sqrt(3/2)/2],  //1
	[-5/(3*sqrt(3)), 0, 5/(6*sqrt(6))],  //2
	[-1/(2*sqrt(3)), -1/2, -1/(2*sqrt(6))],  //3
	[-1/(2*sqrt(3)), +1/2, -1/(2*sqrt(6))],  //4
	[5/(6*sqrt(3)), -5/6, 5/(6*sqrt(6))],  //5
	[5/(6*sqrt(3)), +5/6, 5/(6*sqrt(6))],  //6
	[1/sqrt(3), 0, -(1/(2*sqrt(6)))]   //7
];		
FACES_TRIAKIS_TETRAHEDRON = [
	[1, 6, 5], [5, 6, 7], [2, 1, 5], [1, 2, 6], [6, 2, 4], [2, 5, 3], [3, 5, 0], [5, 7, 0], [6, 0, 7], [6, 4, 0], [4, 2, 0], [2, 3, 0]
];
CIRCUMRADIUS_TRIAKIS_TETRAHEDRON = 1;
		
// Source: https://en.wikipedia.org/wiki/Rhombic_dodecahedron
VERTICES_RHOMBIC_DODECAHEDRON = [
	[+1/sqrt(3), +1/sqrt(3), +1/sqrt(3)],  //0
	[+1/sqrt(3), +1/sqrt(3), -1/sqrt(3)],  //1
	[+1/sqrt(3), -1/sqrt(3), +1/sqrt(3)],  //2
	[+1/sqrt(3), -1/sqrt(3), -1/sqrt(3)],  //3
	[-1/sqrt(3), +1/sqrt(3), +1/sqrt(3)],  //4
	[-1/sqrt(3), +1/sqrt(3), -1/sqrt(3)],  //5
	[-1/sqrt(3), -1/sqrt(3), +1/sqrt(3)],  //6
	[-1/sqrt(3), -1/sqrt(3), -1/sqrt(3)],  //7
	[+2/sqrt(3), 0, 0],  //8
	[-2/sqrt(3), 0, 0],  //9
	[0, +2/sqrt(3), 0],  //10
	[0, -2/sqrt(3), 0],  //11
	[0, 0, +2/sqrt(3)],  //12
	[0, 0, -2/sqrt(3)]   //13
];
FACES_RHOMBIC_DODECAHEDRON = [
	[12, 4, 10, 0], [12, 0, 8, 2], [12, 2, 11, 6], [12, 6, 9, 4], [13, 3, 8, 1], [13, 1, 10, 5], [13, 5, 9, 7], [13, 7, 11, 3], [4, 9, 5, 10], [0, 10, 1, 8], [2, 8, 3, 11], [9, 6, 11, 7]
];
CIRCUMRADIUS_RHOMBIC_DODECAHEDRON = 2 / sqrt(3);

// Source: https://en.wikipedia.org/wiki/Triakis_octahedron
VERTICES_TRIAKIS_OCTAHEDRON = [
	[+1/2, +1/2, +1/2],  //0
	[+1/2, +1/2, -1/2],  //1
	[+1/2, -1/2, +1/2],  //2
	[+1/2, -1/2, -1/2],  //3
	[-1/2, +1/2, +1/2],  //4
	[-1/2, +1/2, -1/2],  //5
	[-1/2, -1/2, +1/2],  //6
	[-1/2, -1/2, -1/2],  //7
	[0, 0, +1/2 + 1/sqrt(2)],  //8
	[0, 0, -1/2 - 1/sqrt(2)],  //9
	[0, +1/2 + 1/sqrt(2), 0],  //10
	[0, -1/2 - 1/sqrt(2), 0],  //11
	[+1/2 + 1/sqrt(2), 0, 0],  //12
	[-1/2 - 1/sqrt(2), 0, 0],  //13
];		
FACES_TRIAKIS_OCTAHEDRON = [
	[8, 0, 12], [8, 12, 2], [8, 2, 11], [8, 11, 6], [8, 6, 13], [8, 13, 4], [8, 4, 10], [8, 10, 0], [9, 1, 10], [9, 10, 5], [9, 5, 13], [9, 13, 7], [9, 7, 11], [9, 11, 3], [9, 3, 12], [9, 12, 1], [0, 10, 12], [1, 12, 10], [2, 12, 11], [3, 11, 12], [4, 13, 10], [5, 10, 13], [6, 11, 13], [7, 13, 11]
];
CIRCUMRADIUS_TRIAKIS_OCTAHEDRON = (1 + sqrt(2)) / 2;

// Source: https://en.wikipedia.org/wiki/Tetrakis_hexahedron
VERTICES_TETRAKIS_HEXAHEDRON = [
	[-2 * sqrt(2)/3, 0, -2/3],  //0
	[-2 * sqrt(2)/3, 0, +2/3],  //1
	[-1/sqrt(2), -1/sqrt(2), 0],  //2
	[-1/sqrt(2), +1/sqrt(2), 0],  //3
	[0, -2 * sqrt(2)/3, -2/3],  //4
	[0, -2 * sqrt(2)/3, +2/3],  //5
	[0, 0, -1],  //6
	[0, 0, +1],  //7
	[0, 2 * sqrt(2)/3, -2/3],  //8
	[0, 2 * sqrt(2)/3, +2/3],  //9
	[1/sqrt(2), -1/sqrt(2), 0],  //10
	[1/sqrt(2), +1/sqrt(2), 0],  //11
	[2 * sqrt(2)/3, 0, -2/3],  //12
	[2 * sqrt(2)/3, 0, +2/3]   //13
];
FACES_TETRAKIS_HEXAHEDRON =
[
	[7, 9, 13], [7, 13, 5], [7, 5, 1], [7, 1, 9], [10, 5, 13], [10, 13, 12], [10, 12, 4], [10, 4, 5], [2, 1, 5], [2, 5, 4], [2, 4, 0], [2, 0, 1], [3, 9, 1], [3, 1, 0], [3, 0, 8], [3, 8, 9], [11, 9, 8], [11, 8, 12], [11, 12, 13], [11, 13, 9], [6, 8, 0], [6, 0, 4], [6, 4, 12], [6, 12, 8]
];
CIRCUMRADIUS_TETRAKIS_HEXAHEDRON = 1;


//Source: https://en.wikipedia.org/wiki/Deltoidal_icositetrahedron
VERTICES_DELTOIDAL_ICOSITETRAHEDRON = [
	[+1/2*sqrt(5+1/sqrt(2)), +1/2*sqrt(5+1/sqrt(2)), 0],  //0
	[+1/2*sqrt(5+1/sqrt(2)), -1/2*sqrt(5+1/sqrt(2)), 0],  //1
	[-1/2*sqrt(5+1/sqrt(2)), +1/2*sqrt(5+1/sqrt(2)), 0],  //2
	[-1/2*sqrt(5+1/sqrt(2)), -1/2*sqrt(5+1/sqrt(2)), 0],  //3
	[0, +1/2*sqrt(5+1/sqrt(2)), +1/2*sqrt(5+1/sqrt(2))],  //4
	[0, +1/2*sqrt(5+1/sqrt(2)), -1/2*sqrt(5+1/sqrt(2))],  //5
	[0, -1/2*sqrt(5+1/sqrt(2)), +1/2*sqrt(5+1/sqrt(2))],  //6
	[0, -1/2*sqrt(5+1/sqrt(2)), -1/2*sqrt(5+1/sqrt(2))],  //7
	[+1/2*sqrt(5+1/sqrt(2)), 0, +1/2*sqrt(5+1/sqrt(2))],  //8
	[+1/2*sqrt(5+1/sqrt(2)), 0, -1/2*sqrt(5+1/sqrt(2))],  //9
	[-1/2*sqrt(5+1/sqrt(2)), 0, +1/2*sqrt(5+1/sqrt(2))],  //10
	[-1/2*sqrt(5+1/sqrt(2)), 0, -1/2*sqrt(5+1/sqrt(2))],  //11
	[+sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2],  //12
	[+sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2],  //13
	[+sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2],  //14
	[+sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2],  //15
	[-sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2],  //16
	[-sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2],  //17
	[-sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2, +sqrt(2+sqrt(2))/2],  //18
	[-sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2, -sqrt(2+sqrt(2))/2],  //19
	[+sqrt(10+sqrt(2))/2, 0, 0],  //20
	[-sqrt(10+sqrt(2))/2, 0, 0],  //21
	[0, +sqrt(10+sqrt(2))/2, 0],  //22
	[0, -sqrt(10+sqrt(2))/2, 0],  //23
	[0, 0, +sqrt(10+sqrt(2))/2],  //24
	[0, 0, -sqrt(10+sqrt(2))/2]   //25
];
FACES_DELTOIDAL_ICOSITETRAHEDRON =
[
	[20, 8, 12, 0], [20, 0, 13, 9], [20, 9, 15, 1], [20, 1, 14, 8], [21, 10, 18, 3], [21, 3, 19, 11], [21, 11, 17, 2], [21, 2, 16, 10], [22, 4, 16, 2], [22, 2, 17, 5], [22, 5, 13, 0], [22, 0, 12, 4], [23, 6, 14, 1], [23, 1, 15, 7], [23, 7, 19, 3], [23, 3, 18, 6], [24, 8, 14, 6], [24, 6, 18, 10], [24, 10, 16, 4], [24, 4, 12, 8], [25, 11, 19, 7], [25, 7, 15, 9], [25, 9, 13, 5], [25, 5, 17, 11]
];
CIRCUMRADIUS_DELTOIDAL_ICOSITETRAHEDRON = sqrt(10 + sqrt(2)) / 2;

//Source: https://en.wikipedia.org/wiki/Rhombic_triacontahedron
VERTICES_RHOMBIC_TRIACONTAHEDRON = [
	[0, 0, -PHI],
	[0, 0, +PHI],
	[+2/sqrt(5), 0, (+5+3*sqrt(5))/10],
	[-2/sqrt(5), 0, (-5-3*sqrt(5))/10],
	[-1 - 1/sqrt(5), 0, (+5 + sqrt(5))/10],
	[-1 - 1/sqrt(5), 0, (-5 + sqrt(5))/10],	
	[+1 + 1/sqrt(5), 0, (+5 - sqrt(5))/10],
	[+1 + 1/sqrt(5), 0, (-5 - sqrt(5))/10],
	
	[-1/sqrt(5), -sqrt(1 + 2/sqrt(5)), (+5 + sqrt(5))/10],
	[-1/sqrt(5), -sqrt(1 + 2/sqrt(5)), (-5 + sqrt(5))/10],
	[-1/sqrt(5), +sqrt(1 + 2/sqrt(5)), (+5 + sqrt(5))/10],
	[-1/sqrt(5), +sqrt(1 + 2/sqrt(5)), (-5 + sqrt(5))/10],
	[+1/sqrt(5), -sqrt(1 + 2/sqrt(5)), (+5 - sqrt(5))/10],
	[+1/sqrt(5), -sqrt(1 + 2/sqrt(5)), (-5 - sqrt(5))/10],
	[+1/sqrt(5), +sqrt(1 + 2/sqrt(5)), (+5 - sqrt(5))/10],
	[+1/sqrt(5), +sqrt(1 + 2/sqrt(5)), (-5 - sqrt(5))/10],
	
	[(+5+3*sqrt(5))/10, -sqrt((5+sqrt(5))/10), (+5+sqrt(5))/10],
	[(+5+3*sqrt(5))/10, -sqrt((5+sqrt(5))/10), (-5+sqrt(5))/10],
	[(+5+3*sqrt(5))/10, +sqrt((5+sqrt(5))/10), (+5+sqrt(5))/10],
	[(+5+3*sqrt(5))/10, +sqrt((5+sqrt(5))/10), (-5+sqrt(5))/10],
	
	[(-5-3*sqrt(5))/10, -sqrt((5+sqrt(5))/10), (+5-sqrt(5))/10],
	[(-5-3*sqrt(5))/10, -sqrt((5+sqrt(5))/10), (-5-sqrt(5))/10],
	[(-5-3*sqrt(5))/10, +sqrt((5+sqrt(5))/10), (+5-sqrt(5))/10],
	[(-5-3*sqrt(5))/10, +sqrt((5+sqrt(5))/10), (-5-sqrt(5))/10],
	
	[(+5+sqrt(5))/10, +sqrt(2/(5+sqrt(5))), (-5-3*sqrt(5))/10],
	[(-5-sqrt(5))/10, +sqrt(2/(5+sqrt(5))), (+5+3*sqrt(5))/10],
	
	[(+5-sqrt(5))/10, -sqrt((5+sqrt(5))/10), (+5+3*sqrt(5))/10], 
	[(+5-sqrt(5))/10, +sqrt((5+sqrt(5))/10), (+5+3*sqrt(5))/10],
	
	[(-5-sqrt(5))/10, -sqrt((5-sqrt(5))/10), (+5+3*sqrt(5))/10],
	[(+5+sqrt(5))/10, -sqrt((5-sqrt(5))/10), (-5-3*sqrt(5))/10],
	
	[(-5+sqrt(5))/10, -sqrt((5+sqrt(5))/10), (-5-3*sqrt(5))/10],
	[(-5+sqrt(5))/10, +sqrt((5+sqrt(5))/10), (-5-3*sqrt(5))/10]
];
FACES_RHOMBIC_TRIACONTAHEDRON = [
	[1, 26, 8, 28], [1, 28, 4, 25], [1, 25, 10, 27], [1, 27, 18, 2], [1, 2, 16, 26], [0, 31, 23, 3], [0, 3, 21, 30], [0, 30, 13, 29], [0, 29, 7, 24], [0, 24, 15, 31], [3, 23, 5, 21], [31, 15, 11, 23], [24, 7, 19, 15], [29, 13, 17, 7], [30, 21, 9, 13], [28, 8, 20, 4], [26, 16, 12, 8], [2, 18, 6, 16], [27, 10, 14, 18], [25, 4, 22, 10], [4, 20, 21, 5], [8, 12, 13, 9], [16, 6, 7, 17], [18, 14, 15, 19], [10, 22, 23, 11], [23, 22, 4, 5], [21, 20, 8, 9], [13, 12, 16, 17], [7, 6, 18, 19], [15, 14, 10, 11]
];
CIRCUMRADIUS_RHOMBIC_TRIACONTAHEDRON = PHI;


//////////////////////////
// Data: Johnson Solids //
//////////////////////////

// Source: https://en.wikipedia.org/wiki/Square_pyramid
VERTICES_SQUARE_PYRAMID = [
	[+1/2, +1/2, 0],
	[+1/2, -1/2, 0],
	[-1/2, +1/2, 0],
	[-1/2, -1/2, 0],
	[0, 0, 1/sqrt(2)]
];
FACES_SQUARE_PYRAMID = [
	[0, 1, 4], [1, 3, 4], [3, 2, 4], [2, 0, 4], [3, 1, 0, 2]
];
CIRCUMRADIUS_SQUARE_PYRAMID = 1/sqrt(2);

// Source: https://en.wikipedia.org/wiki/Pentagonal_pyramid
VERTICES_PENTAGONAL_PYRAMID = [
	[sqrt(1/2 + 1/(2 * sqrt(5))), 0, 0],
	[1/2 * sqrt((5 - sqrt(5))/10), (-1-sqrt(5))/4, 0],
	[1/2 * sqrt((5 - sqrt(5))/10), (+1+sqrt(5))/4, 0],
	[-sqrt(1/4 + 1/(2 * sqrt(5))), -1/2, 0],
	[-sqrt(1/4 + 1/(2 * sqrt(5))), +1/2, 0],
	[0, 0, sqrt((5 - sqrt(5)) / 10)]
];
FACES_PENTAGONAL_PYRAMID = [
	[0, 1, 5], [1, 3, 5], [3, 4, 5], [4, 2, 5], [2, 0, 5], [0, 2, 4, 3, 1]
];
CIRCUMRADIUS_PENTAGONAL_PYRAMID = sqrt(1/2 + 1/(2 * sqrt(5)));

//Source: https://en.wikipedia.org/wiki/Triangular_cupola
VERTICES_TRIANGULAR_COPULA = [
	[+1/2, +sqrt(3)/2, 0],  //0
	[+1/2, -sqrt(3)/2, 0],  //1
	[-1/2, +sqrt(3)/2, 0],  //2
	[-1/2, -sqrt(3)/2, 0],  //3
	[+1, 0, 0],  //4
	[-1, 0, 0],  //5
	
	[+1/2, +1/sqrt(12), sqrt(2/3)],  //6
	[-1/2, +1/sqrt(12), sqrt(2/3)],  //7
	[0, -1/sqrt(3), sqrt(2/3)]   //8
];
FACES_TRIANGULAR_COPULA = [
	[2, 0, 4, 1, 3, 5], [6, 8, 7],
	[0, 6, 7, 2], [1, 8, 6, 4], [7, 8, 3, 5],
	[8, 1, 3], [7, 5, 2], [6, 0, 4]
];
CIRCUMRADIUS_TRIANGULAR_COPULA = 1;

//Source: https://en.wikipedia.org/wiki/Square_cupola
VERTICES_SQUARE_COPULA = [
	[+(1 + sqrt(2))/2, +1/2, 0],  //0
	[+(1 + sqrt(2))/2, -1/2, 0],  //1
	[-(1 + sqrt(2))/2, +1/2, 0],  //2
	[-(1 + sqrt(2))/2, -1/2, 0],  //3
	[+1/2, +(1 + sqrt(2))/2, 0],  //4
	[+1/2, -(1 + sqrt(2))/2, 0],  //5
	[-1/2, +(1 + sqrt(2))/2, 0],  //6
	[-1/2, -(1 + sqrt(2))/2, 0],  //7

	[+1/sqrt(2), 0, +1/sqrt(2)],  //8
	[-1/sqrt(2), 0, +1/sqrt(2)],  //9
	[0, +1/sqrt(2), +1/sqrt(2)],  //10
	[0, -1/sqrt(2), +1/sqrt(2)]   //11
];
FACES_SQUARE_COPULA = [
	[10, 8, 11, 9], [4, 6, 2, 3, 7, 5, 1, 0],
	[8, 10, 4, 0], [10, 9, 2, 6], [9, 11, 7, 3], [11, 8, 1, 5],
	[1, 8, 0], [4, 10, 6], [2, 9, 3], [7, 11, 5]
];
CIRCUMRADIUS_SQUARE_COPULA = sqrt(1 + sqrt(2) / 2);

//Source: https://en.wikipedia.org/wiki/Pentagonal_cupola
VERTICES_PENTAGONAL_COPULA = [
	[+1, +1 * sqrt(3 + 4 * PHI), 0],  //0
	[+1, -1 * sqrt(3 + 4 * PHI), 0],  //1
	[-1, +1 * sqrt(3 + 4 * PHI), 0],  //2
	[-1, -1 * sqrt(3 + 4 * PHI), 0],  //3
	[+1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],  //4
	[+1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],  //5
	[-1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],  //6
	[-1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],  //7
	[+1 * 2 * PHI, 0, 0],  //8
	[-1 * 2 * PHI, 0, 0],  //9

	[0, +sqrt((10 + 2 * sqrt(5)) / 5), +2 * sqrt((3 - PHI) / 5)],  //10
	[+1 * PHI, +sqrt((5 - sqrt(5)) / 10), +2 * sqrt((3 - PHI) / 5)],  //11
	[-1 * PHI, +sqrt((5 - sqrt(5)) / 10), +2 * sqrt((3 - PHI) / 5)],  //12
	[+1, -sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((3 - PHI) / 5)],  //13
	[-1, -sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((3 - PHI) / 5)],  //14
] / 2;
FACES_PENTAGONAL_COPULA = [
	[0, 2, 6, 9, 7, 3, 1, 5, 8, 4], [10, 11, 13, 14, 12],
	[4, 8, 11], [5, 1, 13], [3, 7, 14], [9, 6, 12], [2, 0, 10],
	[2, 10, 12, 6], [0, 4, 11, 10], [8, 5, 13, 11], [1, 3, 14, 13], [7, 9, 12, 14]
];
CIRCUMRADIUS_PENTAGONAL_COPULA = PHI;
		
//Source: https://en.wikipedia.org/wiki/Pentagonal_rotunda
VERTICES_PENTAGONAL_ROTUNDA = [
	[+1, +1 * sqrt(3 + 4 * PHI), 0],  //0
	[+1, -1 * sqrt(3 + 4 * PHI), 0],  //1
	[-1, +1 * sqrt(3 + 4 * PHI), 0],  //2
	[-1, -1 * sqrt(3 + 4 * PHI), 0],  //3
	[+1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],  //4
	[+1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],  //5
	[-1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],  //6
	[-1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],  //7
	[+1 * 2 * PHI, 0, 0],  //8
	[-1 * 2 * PHI, 0, 0],  //9

	[0, -sqrt((10 + 2 * sqrt(5)) / 5), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],  //10
	[+1, +sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],  //11
	[-1, +sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],  //12
	[+1 * PHI, -sqrt((5 - sqrt(5)) / 10), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],  //13
	[-1 * PHI, -sqrt((5 - sqrt(5)) / 10), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],  //14

	[0, +2 * sqrt((5 + 2 * sqrt(5)) / 5), +sqrt((10 + 2 * sqrt(5)) / 5)],  //15
	[+1 * PHI, -sqrt((25 + 11 * sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)],  //16
	[-1 * PHI, -sqrt((25 + 11 * sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)],  //17
	[+1 * PHI * PHI, +sqrt((5 + sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)],  //18
	[-1 * PHI * PHI, +sqrt((5 + sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)]  //19
] / 2;
FACES_PENTAGONAL_ROTUNDA = [
	[0, 2, 6, 9, 7, 3, 1, 5, 8, 4], [10, 14, 12, 11, 13],
	[2, 15, 12, 19, 6], [9, 19, 14, 17, 7], [3, 17, 10, 16, 1], [5, 16, 13, 18, 8], [4, 18, 11, 15, 0],
	[0, 15, 2], [6, 19, 9], [7, 17, 3], [1, 16, 5], [8, 18, 4],	[10, 17, 14], [14, 19, 12], [12, 15, 11], [11, 18, 13], [13, 16, 10]
];
CIRCUMRADIUS_PENTAGONAL_ROTUNDA = PHI;


//////////////////////////////////
// Data: Regular Star Polyhedra //
//////////////////////////////////

//Source: https://en.wikipedia.org/wiki/Small_stellated_dodecahedron
VERTICES_SMALL_STELLATED_DODECAHEDRON = 
	let (
		stellated_intersections = [
			[0, 11, 4, 6],   //12
			[0, 9, 2, 8],    //13
			[0, 5, 4, 10],   //14
			[0, 1, 8, 6],    //15
			[0, 7, 6, 8],    //16
			[3, 2, 7, 9],    //17
			[3, 6, 7, 9],    //18
			[3, 10, 1, 11],  //19
			[3, 8, 7, 5],    //20
			[3, 4, 5, 11],   //21
			[1, 4, 3, 8],    //22
			[1, 0, 10, 5],   //23
			[1, 6, 8, 7],    //24
			[2, 7, 11, 0],   //25
			[2, 3, 6, 9],    //26
			[2, 5, 11, 4],   //27
			[4, 1, 8, 9],    //28
			[4, 3, 2, 5],    //29
			[6, 3, 10, 11],  //30
			[6, 1, 10, 11]   //31
		],
		vertices_stellated = [for (int = stellated_intersections) line_intersection(VERTICES_ICOSAHEDRON[int[0]], VERTICES_ICOSAHEDRON[int[1]], VERTICES_ICOSAHEDRON[int[2]], VERTICES_ICOSAHEDRON[int[3]])]
	)
	concat(VERTICES_ICOSAHEDRON, vertices_stellated);
FACES_SMALL_STELLATED_DODECAHEDRON = [
	[0, 13, 12], [0, 14, 13], [0, 15, 14], [0, 16, 15], [0, 12, 16],
	[1, 19, 20], [1, 20, 22], [1, 22, 23], [1, 23, 24], [1, 24, 19],
	[2, 12, 13], [2, 25, 12], [2, 26, 25], [2, 27, 26], [2, 13, 27],
	[3, 18, 17], [3, 19, 18], [3, 20, 19], [3, 21, 20], [3, 17, 21],
	[4, 13, 14], [4, 27, 13], [4, 14, 28], [4, 28, 29], [4, 29, 27],
	[5, 22, 20], [5, 20, 21], [5, 21, 29], [5, 29, 28], [5, 28, 22],
	[6, 16, 12], [6, 12, 25], [6, 25, 30], [6, 30, 31], [6, 31, 16],
	[7, 31, 30], [7, 30, 18], [7, 18, 19], [7, 19, 24], [7, 24, 31],
	[8, 14, 15], [8, 15, 23], [8, 23, 22], [8, 22, 28], [8, 28, 14],
	[9, 27, 29], [9, 29, 21], [9, 21, 17], [9, 17, 26], [9, 26, 27],
	[10, 15, 16], [10, 16, 31], [10, 31, 24], [10, 24, 23], [10, 23, 15],
	[11, 30, 25], [11, 25, 26], [11, 26, 17], [11, 17, 18], [11, 18, 30]
];
CIRCUMRADIUS_SMALL_STELLATED_DODECAHEDRON = PHI * sin(180 / 5);


/////////////////////////
// Polyhedron Topology //
/////////////////////////

// Returns all vertices connected to vertex v (via an edge).
function vertices_connected_to_vertex(edges, faces, v) = let(
		ce = edges_connected_to_vertex(edges, v),
		cv = [for (c = flatten(ce)) if (c != v) c],
		mf = [for (f = find_meeting_faces(faces, v)) [for (mv = f) if (is_element(cv, mv)) mv]] 
	) make_edges_cyclic(mf);

// Helper function for vertices_connected_to_vertex.	
function find_meeting_faces(faces, v) = [for (f = faces) if (is_element(f, v)) f];

// Helper function for vertices_connected_to_vertex.	
function make_edges_cyclic(edges, result = []) = let(
		last_v = len(result) == 0 ? edges[0][0] : result[len(result) - 1],
		next_v = [for (i = [0 : len(edges) - 1]) if (is_element(edges[i], last_v)) [other_element(edges[i], last_v), i]][0],
		edges_reduced = vector_remove(edges, [next_v[1]])
	) len(edges_reduced) > 0 ? make_edges_cyclic(edges_reduced, concat(result, next_v[0])) : concat(result, next_v[0]);

// Note that the vertices connected to an edge or a face are literally the edge
// and the face, so that no functions are needed.

// Returns all polyhedron edges connected to vertex v.
function edges_connected_to_vertex(edges, v) = [for (e = edges) if (is_element(e, v)) e];
	
// Returns all polyhedron edges connected to edge e (via a vertex).
function edges_connected_to_edge(edges, e) = [for (ce = concat(edges_connected_to_vertex(edges, e[0]), edges_connected_to_vertex(edges, e[1]))) if (ce != e) ce];
	
// Returns all polyhedron edges connected to face f.
function edges_connected_to_face(edges, f) = [for (e = edges) if (is_element(f, e[0]) && is_element(f, e[1])) e];
	
// Returns all polyhedron faces connected to vertex v.
function faces_connected_to_vertex(faces, v) = [for (f = faces) if (is_element(f, v)) f];

// Returns all polyhedron faces connected to edge e.
function faces_connected_to_edge(faces, e) = [for (f = faces) if (is_element(f, e[0]) && is_element(f, e[1])) f];

// Returns all polyhedron faces connected to face f (via an edge).
function faces_connected_to_face(edges, faces, f) = [for (cf = [for (e = edges_connected_to_face(edges, f)) each faces_connected_to_edge(faces, e)]) if (cf != f) cf];
	
// Returns all edges of a polyhedra given its faces.
function get_all_edges(faces, i = 0, r = []) = 
	assert(is_list(faces), str("get_all_edges: faces ", faces, " is not a list"))
	delete_cyclic_duplicates(let(f = faces[i]) i < len(faces) ? get_all_edges(faces, i + 1, concat(r, get_edges(f))) : r);
function get_edges(face) = [for (i = [0 : len(face) - 1]) [face[i], face[(i + 1) % len(face)]]];


/////////////////////////
// Polyhedron Geometry //
/////////////////////////

// Returns a list with the centers (3D coordinates) of all the faces of the polyhedron.
function polyhedron_faces_center(id) =
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_center: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id),
		vertices = polyhedron_vertices(id)
	)
	[for (f = faces) mean([for (v = f) vertices[v]])];

// Returns a list of rotations [angle, rot_vector] for all the faces of the polyhedron.
// The rotation transforms an object from the xy-plane onto the face.
// TODO: orientation can be choosen along many axes of the face (point to point, point to edge, etc.)
function polyhedron_faces_orientation(id) = 
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_orientation: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id),
		vertices = polyhedron_vertices(id),
		normals = [for (f = faces) normal_vector(vertices[f[0]], vertices[f[1]], vertices[f[2]])],
		normal_xy = [0, 0, -1]
	)
	[for (n = normals) [-acos(n * normal_xy / norm(n)), cross(n, normal_xy)]];

// Returns a list with the incircle radii of all the faces of the polyhedron.
function polyhedron_faces_inradius(id) = 
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_inradius: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id)
		//vertices = polyhedron_vertices(id),
		//face_vertices = [for (f = faces) [for(v = f) vertices[v]]]
	)
	//[for (f = face_vertices) norm((f[0] + f[1]) / 2 - mean(f))];
	// TODO: this works for regular polyhedra, change if we have irregular ones.
	// This is faster for regular ones.
	[for (f = faces) 1 / tan(180 / len(f)) / 2];
		
// Returns the dihedral angle between two polyhedron faces (f1 and f2 are lists of vertex numbers).
// This is the angle between f1, the edge (f1-f2) and f2.
function dihedral_angle(vertices, f1, f2) = let
(
	n1 = face_normal(vertices, f1),
	n2 = face_normal(vertices, f2)
) acos(-n1 * n2 / (norm(n1) * norm(n2)));

// Return the partial dihedral angle between the two polyhedron faces (f1 and f2 are lists of vertex numbers).
// The is the angle between f1, the edge (f1-f2) and the center of the polyhedron.
function partial_dihedral_angle(vertices, f1, f2) = let
(
	n1 = face_normal(vertices, f1),
	shared_v = [for (v = f1) if (is_element(f2, v)) v],
	nc = normal_vector([0, 0, 0], vertices[shared_v[0]], vertices[shared_v[1]])
) acos(n1 * nc / (norm(n1) * norm(nc)));


/////////////////
// Mathematics //
/////////////////

// Positive modulo operator (returns i % n on the positive domain).
function mod_plus(i, n) = (i % n + n) % n;

// Calculates the sum of a vector (elements of the vector may also be vectors).
function sum(v) = [for (e = v) 1] * v;
	
// Calculates the mean of a vector (elements of the vector may also be vectors).
function mean(v) = sum(v) / len(v);

// Determines whether elem is part of vector (v).
function is_element(v, elem) = assert(is_list(v), str("is_element: v ", v, " is not a list")) search([elem], v, num_returns_per_match = 1) != [[]];

// Returns the other element in a vector of length two.
function other_element(v, elem) =
	assert(len(v) == 2, str("other_element: v ", v, " does not have two elements"))
	v[0] == elem ? v[1] : v[0];

// Returns a vector with the indexes from elements removed.
function vector_remove(v, elements) = [for (i = [0 : len(v) - 1]) if (!search(i, elements)) v[i]];

// Flattens a vector with two dimensions.
function flatten(v) = [for (a = v) for (b = a) b];

// Cycles the elements of v forwards once (first element goes to last position).
function cycle(v) = [for (i = [0 : len(v) - 1]) v[(i + 1) % len(v)]];
	
// Cycles the elements of v such that e1 and e2 are first.
function cycle_to_first(v, e1, e2) = (v[0] == e1 && v[1] == e2) || (v[0] == e2 && v[1] == e1) ? v : cycle_to_first(cycle(v), e1, e2);

// Deletes all duplicates in a vector.
function delete_duplicates(v, i = 0, r = []) = let(e = v[i]) i < len(v) ? delete_duplicates(v, i + 1, (is_element(r, e) ? r : concat(r, [e]))) : r;
// TODO: fix cyclic elements.
function delete_cyclic_duplicates(v, i = 0, r = []) = let(e = v[i]) i < len(v) ? delete_cyclic_duplicates(v, i + 1, (is_element(r, e) || is_element(r, cycle(e)) ? r : concat(r, [e]))) : r;

// Rotates a vector (v) around axis (axis) by an angle (a).
// Uses the Rodrigues rotation formula https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula.
function rotate_vector(v, a, axis) = v * cos(a) + cross(axis, v) * sin(a) + axis * (axis * v) * (1 - cos(a));

// Gives the rotation matrix corresponding to the rotation in the XYZ format for the OpenSCAD rotate() function.
// Uses https://en.wikipedia.org/wiki/Euler_angles, in particular Tait-Bryan angles: Z1 Y2 X3 from the table.
function rotation_matrix(rot) = let
(
	c1 = cos(rot[2]), s1 = sin(rot[2]),
	c2 = cos(rot[1]), s2 = sin(rot[1]),
	c3 = cos(rot[0]), s3 = sin(rot[0])
)[
	[c1*c2,	c1*s2*s3 - c3*s1,	s1*s3 + c1*c3*s2],
	[c2*s1,	c1*c3 + s1*s2*s3,	c3*s1*s2 - c1*s3], 
	[-s2,	c2*s3,				c3*c3]
];


//////////////
// Geometry //
//////////////

// Calculates the point where two 3D lines intersect, the two lines are given by (v1, v2) and (v3, v4).
function line_intersection(v1, v2, v3, v4) = let (a = v1 - v2, b = v4 - v3, c = v3 - v1) v1 + a * (cross(c, b) * cross(a, b)) / pow(norm(cross(a, b)), 2);

// Calculates the distance between two parallel planes.
function parallel_plane_distance(p1, p2) = let (n1 = plane_orthonormal(p1), n2 = plane_orthonormal(p2)) assert(norm(n1 - n2) < pow(10, -5)) abs((p1[0] - p2[0]) * n1);
function plane_orthonormal(p) = let(v1 = p[0] -  mean(p), v2 = p[1] - mean(p), n = cross(v2, v1)) n / norm(n);
	
// Rotation for a shape pointing straight up (along the z-axis) to align with two points.
function rotation_to_points(p1, p2) = let(
	rx = norm(p1 - p2) != 0 ? -acos((p2[2] - p1[2]) / norm(p1 - p2)) : 0,
	rz = -atan2(p2[0] - p1[0], p2[1] - p1[1])
	) [rx, 0, rz];

// Returns the normal vector for a plane given by three points.
function normal_vector(p1, p2, p3) = cross(p2 - p1, p3 - p1);
function face_normal(vertices, face) = let(points = [for (v = face) vertices[v]]) normal_vector(points[0], points[1], points[2]);

// Gives the faces for a right prism, where the two main surfaces are simple n-gons.
function right_prism_faces(n) = concat(
	[
		[for (k = [n - 1 : -1 : 0]) k],
		[for (k = [n : 2 * n - 1]) k]
	],
	[for (k = [0 : n - 1]) [k % n, (k + 1) % n, n + (k + 1) % n, n + k % n]]
);


///////////////
// Debugging //
///////////////

// Draws a number at each polyhedral vertex for identification and debugging.
module number_vertices(id, a = 1, n = 5, m = 2, r = 0)
{
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	vertices = (side + side / 5) * polyhedron_vertices(id, n = n, m = m);
	for (i = [0 : len(vertices) - 1])
	{
		color("Red")
			translate(vertices[i])
				linear_extrude(height = side / 20)		
					text(text = str(i), halign = "center", valign = "center", size = side / 5);
	};
}

// Draws a number at each polyhedral face for identification and debugging.
module number_faces(id, a = 1, n = 5, m = 2, r = 0)
{
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	faces = side * polyhedron_faces_center(id);
	for (i = [0 : len(faces) - 1])
	{
		face_center = faces[i];
		color("Blue")
			translate(face_center)
				rotate(rotation_to_points([0, 0, 0], face_center))
					linear_extrude(height = side / 20)
						text(str(i), halign = "center", valign = "center",  size = side / 5);
	};
}

// Draws a number at each polyhedral edge for identification and debugging.
module number_edges(id, a = 1, n = 5, m = 2, r = 0)
{
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	vertices = side * polyhedron_vertices(id, n = n, m = m);
	for (i = [0 : len(edges) - 1])
	{
		edge_center = (vertices[edges[i][0]] + vertices[edges[i][1]]) / 2;
		color("Green")
			translate(edge_center)
				rotate(rotation_to_points([0, 0, 0], edge_center))
					linear_extrude(height = side / 20)
						text(str(i), halign = "center", valign = "center",  size = side / 5);
	};
}
