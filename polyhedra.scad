/* Polyhedra Library
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Library for the drawing of polyhedra. Implements the following polyhedra:
 *
 * |---------------------------------------------|-----------------|
 * | id                                          |  F  |  E  |  V  |
 * |---------------------------------------------|-----------------|
 * | --- platonic solids ------------------------| --------------- |
 * | tetrahedron                                 |   4 |   6 |   4 | 
 * | hexahedron                                  |   6 |  12 |   8 |
 * | octahedron                                  |   8 |  12 |   6 |
 * | dodecahedron                                |  12 |  30 |  20 |
 * | icosahedron                                 |  20 |  30 |  12 |
 * | --- archimedean solids -------------------- | --------------- |
 * | truncated_tetrahedron                       |   8 |  18 |  12 |
 * | cuboctahedron                               |  14 |  24 |  12 |
 * | truncated_cube                              |  14 |  36 |  24 |
 * | truncated_octahedron                        |  14 |  36 |  24 |
 * | rhombicuboctahedron                         |  26 |  48 |  24 |
 * | truncated_cuboctahedron                     |  26 |  72 |  48 |
 * | snub_cube_(laevo/dextro)                    |  38 |  60 |  24 |
 * | icosidodecahedron                           |  32 |  60 |  30 |
 * | truncated_dodecahedron                      |  32 |  90 |  60 |
 * | truncated_icosahedron                       |  32 |  90 |  60 |
 * | rhombicosidodecahedron                      |  62 | 120 |  60 |
 * | truncated_icosidodecahedron                 |  62 | 120 | 120 |
 * | snub_dodecahedron_(laevo/dextro)            |  92 | 150 |  60 |
 * | --- catalan solids ------------------------ | --------------- |
 * | triakis_tetrahedron                         |  12 |  18 |   8 |
 * | rhombic_dodecahedron                        |  12 |  24 |  14 |
 * | triakis_octahedron                          |  24 |  36 |  14 |
 * | tetrakis_hexahedron                         |  24 |  36 |  14 |
 * | deltoidal_icositetrahedron                  |  24 |  48 |  26 |
 * | disdyakis_dodecahedron                      |  48 |  72 |  26 |
 * | pentagonal_icositetrahedron_(laevo/dextro)  |  24 |  60 |  38 |
 * | rhombic_triacontahedron                     |  30 |  60 |  32 |
 * | triakis_icosahedron                         |  60 |  90 |  32 |
 * | pentakis_dodecahedron                       |  60 |  90 |  32 |
 * | deltoidal_hexecontahedron                   |  60 | 120 |  62 |
 * | disdyakis_triacontahedron                   | 120 | 180 |  62 |
 * | pentagonal_hexecontahedron_(laevo/dextro)   |  60 | 150 |  92 |
 * | --- regular n-gon polyhedra --------------- | --------------- |
 * | prism                                       | 2+n |  3n |  2n |
 * | antiprism                                   |2n+2 |  4n |  2n |
 * | twisted_prism                               |2n+2 |  4n |  2n |
 * | trapezohedron (TODO)                        |  2n |  4n | 2n+2|
 * | star_prism (TODO)                           |     |     |     |
 * | star_dipyramid (TODO)                       |     |     |     |
 * | --- johnson solids ------------------------ | --------------- |
 * | square pyramid [J1]                         |   5 |   8 |   5 |
 * | pentagonal_pyramid [J2]                     |   6 |  10 |   6 |
 * | triangular_copula [J3]                      |   8 |  15 |   9 |
 * | square_copula [J4]                          |  10 |  20 |  12 |
 * | pentagonal_copula [J5]                      |  12 |  25 |  15 |
 * | pentagonal_rotunda [J6]                     |  17 |  35 |  20 |
 * | snub_disphenoid [J84]                       |  12 |  18 |   8 |
 * | --- regular star polyhedra ---------------- | --------------- |
 * | small_stellated_dodecahedron                |  12 |  30 |  12 |
 * |---------------------------------------------|-----------------|
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
 * | get_face_types                  | returns the faces types (the different N-gons)    |
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
 * Usage documentation:
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

// Fix inscribed circle radius for non-regular polygon faces.

// Figure out circumradius for Johnson solids.

// Check preview for non-convex polyhedra with cut-outs.

// Properly test topology functions.

// Speed testing and implementing speed ups, e.g. numerical values for the vertices.

// Add assertions for most functions and modules depending on computational slow down.


/////////////
// Drawing //
/////////////
	
// Returns a list of the available polyhedra in this library.
function list_polyhedra() =
[
	// Platonic solids.
	"tetrahedron", "hexahedron", "octahedron", "dodecahedron", "icosahedron", 
	// Archimedean solids.
	"truncated_tetrahedron", "cuboctahedron", "truncated_cube", "truncated_octahedron", "rhombicuboctahedron", "truncated_cuboctahedron", "snub_cube", "snub_cube_laevo", "snub_cube_dextro", "icosidodecahedron", "truncated_dodecahedron", "truncated_icosahedron", "rhombicosidodecahedron", "truncated_icosidodecahedron", "snub_dodecahedron", "snub_dodecahedron_laevo", "snub_dodecahedron_dextro",
	// Catalan solids.
	"triakis_tetrahedron", "rhombic_dodecahedron", "triakis_octahedron", "tetrakis_hexahedron", "deltoidal_icositetrahedron", "disdyakis_dodecahedron", "pentagonal_icositetrahedron", "pentagonal_icositetrahedron_laevo", "pentagonal_icositetrahedron_dextro", "rhombic_triacontahedron", "triakis_icosahedron", "pentakis_dodecahedron", "deltoidal_hexecontahedron", "disdyakis_triacontahedron", "pentagonal_hexecontahedron", "pentagonal_hexecontahedron_laevo", "pentagonal_hexecontahedron_dextro",
	// Regular N-gon Polyhedra.
	"prism", "antiprism", "twisted_prism", "twisted_prism_laevo", "twisted_prism_dextro", "trapezohedron", "star_prism", "star_dipyramid", 
	// Johnson solids.
	"square_pyramid", "pentagonal_pyramid", "triangular_copula", "square_copula", "pentagonal_copula", "pentagonal_rotunda", "snub_disphenoid", "bilunabirotunda",
	// Regular star polyhedra.
	"small_stellated_dodecahedron",
	// Zonohedra.
	"bilinski_dodecahedron", "elongated_dodecahedron", "rhombic_icosahedron", 
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
module draw_polyhedron_wire_frame(id, a = 1, n = 5, m = 2, r = 0, t = 1, edge_list = undef)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_polyhedron_wire_frame: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	wire_edges = is_undef(edge_list) ? edges : [for (e = edge_list) edges[e]];
	for (e = wire_edges)
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
					sphere(r = t / 2, $fn = 8);
				}
	}
}

// Draws the specified polyhedron as a set of polygon panels that cover the faces, with panel thickness (t).
// The panel is centered at the faces location according to the parameter a (or alternatively r).
module draw_polyhedron_panels(id, a = 1, n = 5, m = 2, r = 0, t = 1, face_list = undef)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_polyhedron_panels: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id, n = n, m = m);
	faces = polyhedron_faces(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	panel_faces = is_undef(face_list) ? faces : [for (f = face_list) faces[f]];
	for (face = panel_faces)
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
	: id == "snub_cube" || id == "snub_cube_laevo" ?
		VERTICES_SNUB_CUBE_LAEVO
	: id == "snub_cube_dextro" ?
		VERTICES_SNUB_CUBE_DEXTRO
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
	: id == "snub_dodecahedron" || id == "snub_dodecahedron_laevo" ?
		VERTICES_SNUB_DODECAHEDRON_LAEVO
	: id == "snub_dodecahedron_dextro" ?
		VERTICES_SNUB_DODECAHEDRON_DEXTRO
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
	: id == "disdyakis_dodecahedron" ?
		VERTICES_DISDYAKIS_DODECAHEDRON
	: id == "pentagonal_icositetrahedron" || id == "pentagonal_icositetrahedron_laevo" ?
		VERTICES_PENTAGONAL_ICOSITETRAHEDRON_LAEVO
	: id == "pentagonal_icositetrahedron_dextro" ?
		VERTICES_PENTAGONAL_ICOSITETRAHEDRON_DEXTRO
	: id == "rhombic_triacontahedron" ?	
		VERTICES_RHOMBIC_TRIACONTAHEDRON
	: id == "triakis_icosahedron" ?	
		VERTICES_TRIAKIS_ICOSAHEDRON
	: id == "pentakis_dodecahedron" ?	
		VERTICES_PENTAKIS_DODECAHEDRON
	: id == "deltoidal_hexecontahedron" ?	
		VERTICES_DELTOIDAL_HEXECONTAHEDRON
	: id == "disdyakis_triacontahedron" ?	
		VERTICES_DISDYAKIS_TRIACONTAHEDRON
	: id == "pentagonal_hexecontahedron" || id == "pentagonal_hexecontahedron_laevo" ?	
		VERTICES_PENTAGONAL_HEXECONTAHEDRON_LAEVO
	: id == "pentagonal_hexecontahedron_dextro" ?	
		VERTICES_PENTAGONAL_HEXECONTAHEDRON_DEXTRO
	// Regular n-gon polyhedra.
	: id == "prism" ?
		VERTICES_PRISM(n = n)
	: id == "antiprism" ?
		VERTICES_ANTIPRISM(n = n)
	: id == "twisted_prism" || id == "twisted_prism_laevo" || id == "twisted_prism_dextro" ?
		VERTICES_TWISTED_PRISM(n = n)
	: id == "trapezohedron" ?
		VERTICES_TRAPEZOHEDRON(n = n)
	: id == "star_prism" ?
		VERTICES_STAR_PRISM(n = n, m = m)
	: id == "star_dipyramid" ?
		VERTICES_STAR_DIPYRAMID(n = n, m = m)
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
	: id == "snub_disphenoid" ?	
		VERTICES_SNUB_DISPHENOID
	: id == "bilunabirotunda" ?	
		VERTICES_BILUNABIROTUNDA
	// Regular star polyhedra.
	: id == "small_stellated_dodecahedron" ?
		VERTICES_SMALL_STELLATED_DODECAHEDRON
	// Zonohedra.
	: id == "bilinski_dodecahedron" ?
		VERTICES_BILINSKI_DODECAHEDRON	
	: id == "elongated_dodecahedron" ?
		VERTICES_ELONGATED_DODECAHEDRON	
	: id == "rhombic_icosahedron" ?
		VERTICES_RHOMBIC_ICOSAHEDRON	
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
	: id == "snub_cube" || id == "snub_cube_laevo" ?
		FACES_SNUB_CUBE_LAEVO
	: id == "snub_cube_dextro" ?
		FACES_SNUB_CUBE_DEXTRO
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
	: id == "snub_dodecahedron" || id == "snub_dodecahedron_laevo" ?
		FACES_SNUB_DODECAHEDRON_LAEVO
	: id == "snub_dodecahedron_dextro" ?
		FACES_SNUB_DODECAHEDRON_DEXTRO
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
	: id == "disdyakis_dodecahedron" ?
		FACES_DISDYAKIS_DODECAHEDRON
	: id == "pentagonal_icositetrahedron" || id == "pentagonal_icositetrahedron_laevo" ?
		FACES_PENTAGONAL_ICOSITETRAHEDRON_LAEVO
	: id == "pentagonal_icositetrahedron_dextro" ?
		FACES_PENTAGONAL_ICOSITETRAHEDRON_DEXTRO
	: id == "rhombic_triacontahedron" ?	
		FACES_RHOMBIC_TRIACONTAHEDRON
	: id == "triakis_icosahedron" ?	
		FACES_TRIAKIS_ICOSAHEDRON
	: id == "pentakis_dodecahedron" ?	
		FACES_PENTAKIS_DODECAHEDRON
	: id == "deltoidal_hexecontahedron" ?	
		FACES_DELTOIDAL_HEXECONTAHEDRON
	: id == "disdyakis_triacontahedron" ?	
		FACES_DISDYAKIS_TRIACONTAHEDRON
	: id == "pentagonal_hexecontahedron" || id == "pentagonal_hexecontahedron_laevo" ?	
		FACES_PENTAGONAL_HEXECONTAHEDRON_LAEVO
	: id == "pentagonal_hexecontahedron_dextro" ?	
		FACES_PENTAGONAL_HEXECONTAHEDRON_DEXTRO
	// Regular n-gon polyhedra.
	: id == "prism" ?
		FACES_PRISM(n = n)
	: id == "antiprism" ?
		FACES_ANTIPRISM(n = n)
	: id == "twisted_prism" || id == "twisted_prism_laevo"?
		FACES_TWISTED_PRISM_LAEVO(n = n)
	: id == "twisted_prism_dextro" ?
		FACES_TWISTED_PRISM_DEXTRO(n = n)
	: id == "trapezohedron" ?
		FACES_TRAPEZOHEDRON(n = n)
	: id == "star_prism" ?
		FACES_STAR_PRISM(n = n, m = m)
	: id == "star_dipyramid" ?
		FACES_STAR_DIPYRAMID(n = n, m = m)
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
	: id == "snub_disphenoid" ?	
		FACES_SNUB_DISPHENOID
	: id == "bilunabirotunda" ?	
		FACES_BILUNABIROTUNDA
	// Regular star polyhedra.
	: id == "small_stellated_dodecahedron" ?
		FACES_SMALL_STELLATED_DODECAHEDRON
	// Zonohedra.
	: id == "bilinski_dodecahedron" ?
		FACES_BILINSKI_DODECAHEDRON	
	: id == "elongated_dodecahedron" ?
		FACES_ELONGATED_DODECAHEDRON
	: id == "rhombic_icosahedron" ?
		FACES_RHOMBIC_ICOSAHEDRON
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
	: id == "snub_cube" || id == "snub_cube_laevo" || id == "snub_cube_dextro" ?
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
	: id == "snub_dodecahedron" || id == "snub_dodecahedron_laevo" || id == "snub_dodecahedron_dextro" ?
		CIRCUMRADIUS_SNUB_DODECAHEDRON
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
	: id == "disdyakis_dodecahedron" ?
		CIRCUMRADIUS_DISDYAKIS_DODECAHEDRON
	: id == "pentagonal_icositetrahedron" || id == "pentagonal_icositetrahedron_laevo" || id == "pentagonal_icositetrahedron_dextro" ?
		CIRCUMRADIUS_PENTAGONAL_ICOSITETRAHEDRON
	: id == "rhombic_triacontahedron" ?	
		CIRCUMRADIUS_RHOMBIC_TRIACONTAHEDRON
	: id == "triakis_icosahedron" ?	
		CIRCUMRADIUS_TRIAKIS_ICOSAHEDRON
	: id == "pentakis_dodecahedron" ?	
		CIRCUMRADIUS_PENTAKIS_DODECAHEDRON
	: id == "deltoidal_hexecontahedron" ?	
		CIRCUMRADIUS_DELTOIDAL_HEXECONTAHEDRON
	: id == "disdyakis_triacontahedron" ?	
		CIRCUMRADIUS_DISDYAKIS_TRIACONTAHEDRON
	: id == "pentagonal_hexecontahedron" || id == "pentagonal_hexecontahedron_laevo" || id == "pentagonal_hexecontahedron_dextro" ?	
		CIRCUMRADIUS_PENTAGONAL_HEXECONTAHEDRON	
	// Regular n-gon polyhedra.
	: id == "prism" ?
		CIRCUMRADIUS_PRISM(n = n)
	: id == "antiprism" ?
		CIRCUMRADIUS_ANTIPRISM(n = n)
	: id == "twisted_prism" || id == "twisted_prism_laevo" || id == "twisted_prism_dextro" ?
		CIRCUMRADIUS_TWISTED_PRISM(n = n)
	: id == "trapezohedron" ?
		CIRCUMRADIUS_TRAPEZOHEDRON(n = n)
	: id == "star_prism" ?
		CIRCUMRADIUS_STAR_PRISM(n = n, m = m)
	: id == "star_dipyramid" ?
		CIRCUMRADIUS_STAR_DIPYRAMID(n = n, m = m)
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
	: id == "snub_disphenoid" ?	
		CIRCUMRADIUS_SNUB_DISPHENOID
	: id == "bilunabirotunda" ?	
		CIRCUMRADIUS_BILUNABIROTUNDA
	// Regular star polyhedra.
	: id == "small_stellated_dodecahedron" ?
		CIRCUMRADIUS_SMALL_STELLATED_DODECAHEDRON
	// Zonohedra.
	: id == "bilinski_dodecahedron" ?
		CIRCUMRADIUS_BILINSKI_DODECAHEDRON	
	: id == "elongated_dodecahedron" ?
		CIRCUMRADIUS_ELONGATED_DODECAHEDRON
	: id == "rhombic_icosahedron" ?
		CIRCUMRADIUS_RHOMBIC_ICOSAHEDRON
	:
		undef
);


/////////////////////
// Polyhedron Data //
/////////////////////

include <data/constants.scad>
include <data/platonic.scad>
include <data/archimedean.scad>
include <data/catalan.scad>
include <data/johnson.scad>
include <data/regular-ngon.scad>
include <data/regular-star.scad>
include <data/zonohedra.scad>


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

// Returns the types of faces the given polyhedron has as a vector, representing the N-gonal faces of the polyhedron.
// TODO: the polyhedron can have different faces with the same number of vertices.
function get_face_types(faces) = delete_duplicates([for (f = faces) len (f)]);


/////////////////////////
// Polyhedron Geometry //
/////////////////////////

// Returns a list with the centers (3D coordinates) of all the faces of the polyhedron.
function polyhedron_faces_center(id, n = 5, m = 2) =
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_center: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id, n = n, m = m),
		vertices = polyhedron_vertices(id, n = n, m = m)
	)
	[for (f = faces) mean([for (v = f) vertices[v]])];

// Returns a list of rotations [angle, rot_vector] for all the faces of the polyhedron.
// The rotation transforms an object from the xy-plane onto the face.
// TODO: orientation can be choosen along many axes of the face (point to point, point to edge, etc.)
function polyhedron_faces_orientation(id, n = 5, m = 2) = 
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_orientation: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id, n = n, m = m),
		vertices = polyhedron_vertices(id, n = n, m = m),
		normals = [for (f = faces) normal_vector(vertices[f[0]], vertices[f[1]], vertices[f[2]])],
		normal_xy = [0, 0, -1]
	)
	[for (n = normals) [-acos(n * normal_xy / norm(n)), cross(n, normal_xy)]];

// Returns a list with the incircle radii of all the faces of the polyhedron.
function polyhedron_faces_inradius(id, n = 5, m = 2) = 
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_inradius: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id, n = n, m = m)
		//vertices = polyhedron_vertices(id, n = n, m = m),
		//face_vertices = [for (f = faces) [for(v = f) vertices[v]]]
	)
	//[for (f = face_vertices) norm((f[0] + f[1]) / 2 - mean(f))];
	// TODO: this works for regular polyhedra, change if we have irregular ones.
	// This is faster for regular ones.
	[for (f = faces) 1 / tan(180 / len(f)) / 2];
		
// Returns a list with the incircle radii of all the faces of the polyhedron.
function polyhedron_faces_circumradius(id, n = 5, m = 2) = 
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_circumradius: ", id, " is not a valid polyhedron."))
	let (
		faces = polyhedron_faces(id, n = n, m = m)
		//vertices = polyhedron_vertices(id, n = n, m = m),
		//face_vertices = [for (f = faces) [for(v = f) vertices[v]]]
	)
	//[for (f = face_vertices) norm(f[0] - mean(f))];
	// TODO: this works for regular polyhedra, change if we have irregular ones.
	// This is faster for regular ones.
	[for (f = faces) 1 / sin(180 / len(f)) / 2];
		
// Returns the rotation angle and axis [angle, [x, y, z]] to rotate the polyhedron with its first vertex aligned with the north pole [0, 0, 1].
function polyhedron_rotation_to_pole(id, n = 5, m = 2) = 
	assert(is_element(list_polyhedra(), id), str("polyhedron_faces_circumradius: ", id, " is not a valid polyhedron."))
	let(
		pole = [0, 0, circumradius_factor(id, n, m)],
		poly_p = polyhedron_vertices(id, n, m)[0],
		// Polyhedron may already be aligned in which case norm(axis) == 0, this is caught later.
		axis = normal_vector([0, 0, 0], pole, poly_p),
		rot = acos(pole * poly_p / (norm(pole) * norm(poly_p)))
	) norm(axis) == 0 || is_undef(axis) ? [0, [0, 0, 1]] : [rot, axis];
		
// Returns the dihedral angle between two polyhedron faces (f1 and f2 are lists of vertex numbers).
// This is the angle between f1, the edge (f1-f2) and f2.
// TODO: Fix issue with minus signs (example twisted prisms).
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

// Returns the length of the given edge (e) of the polyhedron.
function edge_length(vertices, e) = norm(vertices[e[0]] - vertices[e[1]]);

// Returns the planar angles of each vertex in the face.
function face_vertex_angles(vertices, face) = let 
(
	points = [for (f = face) vertices[f]]
) [for(n = [1 : len(points)]) vertex_angle(points[n - 1], points[n % len(points)], points[(n + 1) % len(points)])]; 
function vertex_angle(p1, p2, p3) = acos((p1 - p2) * (p3 - p2) / (norm(p1 - p2) * norm(p3 - p2)));

// Returns the edge lengthes of all edges of the face.
function face_edge_lengths(vertices, face) = let
(
	points = [for (f = face) vertices[f]],
	n_max = len(points)
) [for(n = [1 : n_max]) norm(points[n - 1] - points[n % n_max])]; 
	
// Returns the surface area of the face.
function face_area(vertices, face) = let
(
	// Construct a normalized basis for the face and project the 3d face onto this 2d plane.
	points = [for (f = face) vertices[f]],
	normal = plane_orthonormal(points),
	center = mean(points),
	points_centered = [for (p = points) p - center],
	ex = points_centered[0] / norm(points_centered[0]),
	ey = cross(ex, normal),
	points_2d = [for (p = points_centered) [ex * p, ey * p]]
) polygon_area(points_2d);


////////////////////////////
// Polyhedron Information //
////////////////////////////

// Returns all different (i.e. unique) dihedral angles of the polyhedron.
function dihedral_angles(id, n = 5, m = 2) = let (
		faces = polyhedron_faces(id, n = n, m = m),
		vertices = polyhedron_vertices(id, n = n, m = m),
		edges = polyhedron_edges(id, n = n, m = m)
) delete_duplicates([for (e = edges) let (f = faces_connected_to_edge(faces, e)) dihedral_angle(vertices, f[0], f[1])]);

// Returns the edge lengths for each face of the polyhedron.
function faces_edge_lengths(id, n = 5, m = 2) = let (
		faces = polyhedron_faces(id, n = n, m = m),
		vertices = polyhedron_vertices(id, n = n, m = m)
) [for (f = faces) face_edge_lengths(vertices, f)];

// Returns the vertex angles for each face of the polyhedron.
function faces_vertex_angles(id, n = 5, m = 2) = let (
		faces = polyhedron_faces(id, n = n, m = m),
		vertices = polyhedron_vertices(id, n = n, m = m)
) [for (f = faces) face_vertex_angles(vertices, f)];

// Returns the area for each face of the polyhedron.
function faces_areas(id, n = 5, m = 2) = let (
		faces = polyhedron_faces(id, n = n, m = m),
		vertices = polyhedron_vertices(id, n = n, m = m)
) [for (f = faces) face_area(vertices, f)];


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
function is_element(v, elem) = assert(is_list(v), str("is_element: v (= ", v, ") is not a list")) search([elem], v, num_returns_per_match = 1) != [[]];

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

// Rotates a vector (v) around a unit axis (axis) by an angle (a).
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
function parallel_plane_distance(p1, p2) = let (n1 = plane_orthonormal(p1), n2 = plane_orthonormal(p2)) assert(norm(n1 - n2) < pow(10, -5) || norm(n1 - n2) - 2 < pow(10, -5), str("p1 !|| p2, n1 - n2 = ", norm(n1 - n2))) abs((p1[0] - p2[0]) * n1);
function plane_orthonormal(p) = let(v1 = p[0] -  mean(p), v2 = p[1] - mean(p), n = cross(v2, v1)) n / norm(n);

// Returns the intersection point between a line (l1, l2) and a plane - point (p1) and normal (n).
// https://rosettacode.org/wiki/Find_the_intersection_of_a_line_with_a_plane#Python
function line_plane_intersection(l1, l2, p, n) = let(
	ndotu = n * (l2 - l1)
) abs(ndotu) < 10^(-8) ? undef : let(
	w = l1 - p,
	si = -n * w / ndotu,
	psi = w + si * (l2 - l1) + p) psi;

// Rotation for a shape pointing straight up (along the z-axis) to align with two points.
function rotation_to_points(p1, p2) = let(
	rx = norm(p1 - p2) != 0 ? -acos((p2[2] - p1[2]) / norm(p1 - p2)) : 0,
	rz = -atan2(p2[0] - p1[0], p2[1] - p1[1])
	) [rx, 0, rz];

// Returns the normal vector for a plane given by three points.
function normal_vector(p1, p2, p3) = let(n = cross(p2 - p1, p3 - p1)) norm(n) == 0 ? undef : n / norm(n);
function face_normal(vertices, face) = let(points = [for (v = face) vertices[v]]) normal_vector(points[0], points[1], points[2]);

// Gives the faces for a right prism, where the two main surfaces are simple n-gons.
function right_prism_faces(n) = concat(
	[
		[for (k = [n - 1 : -1 : 0]) k],
		[for (k = [n : 2 * n - 1]) k]
	],
	[for (k = [0 : n - 1]) [k % n, (k + 1) % n, n + (k + 1) % n, n + k % n]]
);


//////////////
// Polygons //
//////////////

// Vertices in [x, y] for a regular n-gon with radius (r) and first point [r, 0].
function regular_polygon_vertices(n = 3, r = 1) = [for (i = [0 : n - 1]) [r * cos(i * 360 / n), r * sin(i * 360 / n)]];

// Constructs a regular n-gon with radius (r).
module regular_polygon(n = 3, r = 1)
{
     polygon(regular_polygon_vertices(n = n, r = r));
}

// Constructs a regular n-gononal ring with radius (r) and width (w).
module regular_polygon_ring(n = 3, r = 1, w = 1)
{
	r_diff = regular_polygon_radius(n = n, a = regular_polygon_apothem(n = n, r = r) - w);
    difference()
	{
		polygon(regular_polygon_vertices(n = n, r = r));
		polygon(regular_polygon_vertices(n = n, r = r_diff));
	}
}

// Returns the side length of a regular n-gon with radius (r). 
function regular_polygon_side(n = 3, r = 1) = 2 * r * sin(180 / n);

// Returns the apothem (or radius of the inscribed circle) of a regular n-gon with radius (r).
function regular_polygon_apothem(n = 3, r = 1) = r * cos(180 / n);

// Returns the radius of a regular n-gon with apothem (a).
// TODO: get radius from side length as well (needs naming scheme).
function regular_polygon_radius(n = 3, a = 1) = a / cos(180 / n);

// Returns the  regular n-gon with radius (r).
function regular_polygon_internal_angle(n) = 180 * (n - 2) / n;

// Calculates the area of an irregular polygon with points as a list of [x, y] coordinates.
function polygon_area(points) = let
(
	n = len(points),
	xy = [for (m = [0 : n - 1]) points[m][0] * points[(m + 1) % n][1]],
	yx = [for (m = [0 : n - 1]) points[m][1] * points[(m + 1) % n][0]]
) abs((sum(xy) - sum(yx)) / 2);
	

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
