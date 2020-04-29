/* Polyhedra Library
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Library for the drawing of polyhedra. Contains the following polyhedra:
 *
 * === Platonic Solids ===
 *  tetrahedron
 *  hexahedron
 *  octahedron
 *  dodecahedron
 *  icosahedron
 *
 * === Archimedean Solids ===
 *  truncated_tetrahedron
 *  cuboctahedron
 *  truncated_cube
 *  truncated_octahedron
 *  rhombicuboctahedron
 *  truncated_cuboctahedron
 *  snub_cube (MIRROR IMAGE TODO)
 *  icosidodecahedron
 *  truncated_dodecahedron
 *  truncated_icosahedron
 *  rhombicosidodecahedron (TODO)
 *  truncated_icosidodecahedron (TODO)
 *  snub_dodecahedron (MIRROR IMAGE TODO)
 * 
 * === Prisms & Antiprisms ===
 *  prism
 *  antiprism
 *
 *
 * Short usage documentation:
 *
 *  polyhedron(a = 1, r = 0, convexity = 1)
 *   a:          the length of an edge
 *   r:          radius of the circumscribed sphere (overwrites a if non-zero)
 *   convexity:  parameter of polyhedron function in OpenSCAD
 *
 *  (anti)prism(n = 3, a = 1, r = 0, convexity = 1)
 *   n:          the number of vertices/edges for the prism base faces
 *
*/


///////////////
// Constants //
///////////////

// Mathematical constants.
PHI = (1 + sqrt(5)) / 2;
TRIBONACCI = (1 + pow(19 - 3 * sqrt(33), 1/3) + pow(19 + 3 * sqrt(33), 1/3)) / 3;


/////////////
// General //
/////////////
	
// Returns a list of the available polyhedra in this library.
function list_polyhedra() =
[
	// Platonic solids.
	"tetrahedron", "hexahedron", "octahedron", "dodecahedron", "icosahedron", 
	// Archimedean solids.
	"truncated_tetrahedron", "cuboctahedron", "truncated_cube", "truncated_octahedron", "rhombicuboctahedron", "truncated_cuboctahedron", "snub_cube", "icosidodecahedron", "truncated_dodecahedron", "truncated_icosahedron", /*"rhombicosidodecahedron", "truncated_icosidodecahedron",*/ "snub_dodecahedron",
	// Prism, antiprism.
	"prism", "antiprism"
];

// Draws the specified polyhedron.
module draw_polyhedron(id, a = 1, r = 0, convexity = 1)
{ 
	// Platonic solids.
	if (id == "tetrahedron")
		tetrahedron(a = a, r = r, convexity = convexity);
	if (id == "hexahedron")
		hexahedron(a = a, r = r, convexity = convexity);
	if (id == "octahedron")
		octahedron(a = a, r = r, convexity = convexity);
	if (id == "dodecahedron")
		dodecahedron(a = a, r = r, convexity = convexity);
	if (id == "icosahedron")
		icosahedron(a = a, r = r, convexity = convexity);
	// Archimedean solids.
	if (id == "truncated_tetrahedron")
		truncated_tetrahedron(a = a, r = r, convexity = convexity);
	if (id == "cuboctahedron")
		cuboctahedron(a = a, r = r, convexity = convexity);
	if (id == "truncated_cube")
		truncated_cube(a = a, r = r, convexity = convexity);
	if (id == "truncated_octahedron")
		truncated_octahedron(a = a, r = r, convexity = convexity);
	if (id == "rhombicuboctahedron")
		rhombicuboctahedron(a = a, r = r, convexity = convexity);
	if (id == "truncated_cuboctahedron")
		truncated_cuboctahedron(a = a, r = r, convexity = convexity);
	if (id == "snub_cube")
		snub_cube(a = a, r = r, convexity = convexity);
	if (id == "icosidodecahedron")
		icosidodecahedron(a = a, r = r, convexity = convexity);
	if (id == "truncated_dodecahedron")
		truncated_dodecahedron(a = a, r = r, convexity = convexity);
	if (id == "truncated_icosahedron")
		truncated_icosahedron(a = a, r = r, convexity = convexity);
	if (id == "rhombicosidodecahedron")
		rhombicosidodecahedron(a = a, r = r, convexity = convexity);
	if (id == "truncated_icosidodecahedron")
		truncated_icosidodecahedron(a = a, r = r, convexity = convexity);
	if (id == "snub_dodecahedron")
		snub_dodecahedron(a = a, r = r, convexity = convexity);
	// Prism, antiprism.
	if (id == "prism")
		prism(n = 3, a = a, r = r, convexity = convexity);
	if (id == "antiprism")
		antiprism(n = 3, a = a, r = r, convexity = convexity);
}


/////////////////////
// Platonic Solids //
/////////////////////

module tetrahedron(a = 1, r = 0, convexity = 1)
{	
	side = r == 0 ? a : r / CIRCUMRADIUS_TETRAHEDRON;
	polyhedron(VERTICES_TETRAHEDRON * side, FACES_TETRAHEDRON, convexity);
}

module hexahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_HEXAHEDRON;
	polyhedron(VERTICES_HEXAHEDRON * side, FACES_HEXAHEDRON, convexity);
}

module octahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_OCTAHEDRON;
	polyhedron(VERTICES_OCTAHEDRON * side, FACES_OCTAHEDRON, convexity);
}

module dodecahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_DODECAHEDRON;
	polyhedron(VERTICES_DODECAHEDRON * side, FACES_DODECAHEDRON, convexity);
}

module icosahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_ICOSAHEDRON;
	polyhedron(VERTICES_ICOSAHEDRON * side, FACES_ICOSAHEDRON, convexity);
}


////////////////////////
// Archimedean Solids //
////////////////////////

module truncated_tetrahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_TETRAHEDRON;
	polyhedron(VERTICES_TRUNCATED_TETRAHEDRON * side, FACES_TRUNCATED_TETRAHEDRON, convexity);
}

module cuboctahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_CUBOCTAHEDRON;
	polyhedron(VERTICES_CUBOCTAHEDRON * side, FACES_CUBOCTAHEDRON, convexity);
}

module truncated_cube(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_CUBE;
	polyhedron(VERTICES_TRUNCATED_CUBE * side, FACES_TRUNCATED_CUBE, convexity);
}

module truncated_octahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_OCTAHEDRON;
	polyhedron(VERTICES_TRUNCATED_OCTAHEDRON * side, FACES_TRUNCATED_OCTAHEDRON, convexity);
}

module rhombicuboctahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_RHOMBICUBOCTAHEDRON;
	polyhedron(VERTICES_RHOMBICUBOCTAHEDRON * side, FACES_RHOMBICUBOCTAHEDRON, convexity);
}

module truncated_cuboctahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_CUBOCTAHEDRON;
	polyhedron(VERTICES_TRUNCATED_CUBOCTAHEDRON * side, FACES_TRUNCATED_CUBOCTAHEDRON, convexity);
}

// TODO: mirror image
module snub_cube(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_SNUB_CUBE;
	polyhedron(VERTICES_SNUB_CUBE * side, FACES_SNUB_CUBE, convexity);
}

module icosidodecahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_ICOSIDODECAHEDRON;
	polyhedron(VERTICES_ICOSIDODECAHEDRON * side, FACES_ICOSIDODECAHEDRON, convexity);
}

module truncated_dodecahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_DODECAHEDRON;
	polyhedron(VERTICES_TRUNCATED_DODECAHEDRON * side, FACES_TRUNCATED_DODECAHEDRON, convexity);
}

module truncated_icosahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_ICOSAHEDRON;
	polyhedron(VERTICES_TRUNCATED_ICOSAHEDRON * side, FACES_TRUNCATED_ICOSAHEDRON, convexity);
}

module rhombicosidodecahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_RHOMBICOSIDODECAHEDRON;
	polyhedron(VERTICES_RHOMBICOSIDODECAHEDRON * side, FACES_RHOMBICOSIDODECAHEDRON, convexity);
}

module truncated_icosidodecahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_TRUNCATED_ICOSIDODECAHEDRON;
	polyhedron(VERTICES_TRUNCATED_ICOSIDODECAHEDRON * side, FACES_TRUNCATED_ICOSIDODECAHEDRON, convexity);
}

// TODO: mirror image
module snub_dodecahedron(a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_SNUB_DODECAHEDRON;
	polyhedron(VERTICES_SNUB_DODECAHEDRON * side, FACES_SNUB_DODECAHEDRON, convexity);
}


/////////////////////////
// Prisms & Antiprisms //
/////////////////////////

module prism(n = 3, a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_PRISM(n);
	polyhedron(VERTICES_PRISM(n) * side, FACES_PRISM(n), convexity);
}

module antiprism(n = 3, a = 1, r = 0, convexity = 1)
{
	side = r == 0 ? a : r / CIRCUMRADIUS_ANTIPRISM(n);
	polyhedron(VERTICES_ANTIPRISM(n) * side, FACES_ANTIPRISM(n), convexity);
}


/////////////////////////
// Polyhedron Geometry //
/////////////////////////

// Returns a list with the centers (3D coordinates) of all the faces of the polyhedron.
function polyhedron_faces_center(id) =
	let (
		faces = polyhedron_faces(id),
		vertices = polyhedron_vertices(id)
	)
	[for (f = faces) mean([for (v = f) vertices[v]])];

// Returns a list of rotations [angle, rot_vector] for all the faces of the polyhedron.
// The rotation transforms an object from the xy-plane onto the face.
// TODO: orientation can be choosen along many axes of the face (point to point, point to edge, etc.)
function polyhedron_faces_orientation(id) = 
	let (
		faces = polyhedron_faces(id),
		vertices = polyhedron_vertices(id),
		normals = [for (f = faces) normal_vector(vertices[f[0]], vertices[f[1]], vertices[f[2]])],
		normal_xy = [0,0,-1]
	)
	[for (n = normals) [-acos(n * normal_xy / norm(n)), cross(n, normal_xy)]];

// Returns a list with the incircle radii of all the faces of the polyhedron.
function polyhedron_faces_inradius(id) = 
	let (
		faces = polyhedron_faces(id)
		//vertices = polyhedron_vertices(id),
		//face_vertices = [for (f = faces) [for(v = f) vertices[v]]]
	)
	//[for (f = face_vertices) norm((f[0] + f[1]) / 2 - mean(f))];
	// TODO: this works for regular polyhedra, change if we have irregular ones.
	// This is faster for regular ones.
	[for (f = faces) 1 / tan(180 / len(f)) / 2];


///////////////////////////
// Polyhedron Properties //
///////////////////////////

// Returns the polyhedron vertices as a list of 3D coordinates.
// The vertex coordinates are normalized such that the edge length (a) equals 1.
function polyhedron_vertices(id) =
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
	: id == "snub_dodecahedron" ?
		VERTICES_SNUB_DODECAHEDRON
	// Prism, antiprism.
	: id == "prism" ?
		VERTICES_PRISM()
	: id == "antiprism" ?
		VERTICES_ANTIPRISM()
	:
		undef
);

// Returns the polyhedron faces as a list of connecting vertices.
function polyhedron_faces(id) =
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
	: id == "snub_dodecahedron" ?
		FACES_SNUB_DODECAHEDRON
	// Prism, antiprism.
	: id == "prism" ?
		FACES_PRISM()
	: id == "antiprism" ?
		FACES_ANTIPRISM()
	:
		undef
);

// Returns the polyhedron edges as a list of vertex pairs.
function polyhedron_edges(id) = get_all_edges(polyhedron_faces(id));

// Returns the circumradius factor xi (R = xi * a).
function circumradius_factor(id) = 
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
	: id == "snub_dodecahedron" ?
		CIRCUMRADIUS_SNUB_DODECAHEDRON
	// Prism, antiprism.
	: id == "prism" ?
		CIRCUMRADIUS_PRISM()
	: id == "antiprism" ?
		CIRCUMRADIUS_ANTIPRISM()
	:
		undef
);

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

// Source: https://en.wikipedia.org/wiki/Truncated_tetrahedron
VERTICES_TRUNCATED_TETRAHEDRON = [
	[+1 * 3, +1, +1],  //0
	[+1, +1 * 3, +1],  //1
	[+1, +1, +1 * 3],  //2
	[-1 * 3, -1, +1],  //3
	[-1, -1 * 3, +1],  //4
	[-1, -1, +1 * 3],  //5
	[-1 * 3, +1, -1],  //6
	[-1, +1 * 3, -1],  //7
	[-1, +1, -1 * 3],  //8
	[+1 * 3, -1, -1],  //9
	[+1, -1 * 3, -1],  //10
	[+1, -1, -1 * 3]   //11
] / sqrt(8);
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
//	t = (1 + pow(19 - 3 * sqrt(33), 1/3) + pow(19 + 3 * sqrt(33), 1/3)) / 3;
//	beta = pow(26 + 6 * sqrt(33), 1/3);
//	alpha = sqrt(4 / 3 - 16 / (3 * beta) + 2 * beta / 3);
//	gamma = sqrt((3 - t) / (8 - 4 * t));
//	side = r == 0 ? a / alpha : r / alpha / gamma;
CONSTANT_SNUB_CUBE = let (beta = pow(26 + 6 * sqrt(33), 1/3)) sqrt(4 / 3 - 16 / (3 * beta) + 2 * beta / 3);
VERTICES_SNUB_CUBE = [ // for the even mirror image.
	// even permutations
	[+1, +1/TRIBONACCI, -TRIBONACCI],  //1
	[+1, -1/TRIBONACCI, +TRIBONACCI],  //2
	[-1, +1/TRIBONACCI, +TRIBONACCI],  //4
	[-1, -1/TRIBONACCI, -TRIBONACCI],  //7

	[-TRIBONACCI, +1, +1/TRIBONACCI],  //1
	[+TRIBONACCI, -1, +1/TRIBONACCI],  //1
	[+TRIBONACCI, +1, -1/TRIBONACCI],  //1
	[-TRIBONACCI, -1, -1/TRIBONACCI],  //1

	[+1/TRIBONACCI, -TRIBONACCI, +1],  //1
	[-1/TRIBONACCI, +TRIBONACCI, +1],  //1
	[+1/TRIBONACCI, +TRIBONACCI, -1],  //1
	[-1/TRIBONACCI, -TRIBONACCI, -1],  //1
	
	// odd permutations
	[+TRIBONACCI, +1/TRIBONACCI, +1],  //0
	[+TRIBONACCI, -1/TRIBONACCI, -1],  //3
	[-TRIBONACCI, +1/TRIBONACCI, -1],  //5
	[-TRIBONACCI, -1/TRIBONACCI, +1],  //6
	
	[+1/TRIBONACCI, +1, +TRIBONACCI],  //0
	[-1/TRIBONACCI, +1, -TRIBONACCI],  //0
	[+1/TRIBONACCI, -1, -TRIBONACCI],  //0
	[-1/TRIBONACCI, -1, +TRIBONACCI],  //0
	
	[+1, +TRIBONACCI, +1/TRIBONACCI],  //0
	[+1, -TRIBONACCI, -1/TRIBONACCI],  //0
	[-1, -TRIBONACCI, +1/TRIBONACCI],  //0
	[-1, +TRIBONACCI, -1/TRIBONACCI]  //0
] / CONSTANT_SNUB_CUBE;
FACES_SNUB_CUBE = [
	[2, 16, 1, 19], [0, 17, 3, 18], [23, 10, 20, 9], [22, 8, 21, 11], [12, 6, 13, 5], [4, 15, 7, 14],
	
	[19, 1, 8], [19, 8, 22], [15, 19, 22], [15, 22, 7], [2, 19, 15], [2, 15, 4], [2, 4, 9], [16, 2, 9], [16, 9, 20], [16, 20, 12], [16, 12, 1], [1, 12, 5], [1, 5, 8], [9, 4, 23], [4, 14, 23], [12, 20, 6], [20, 10, 6], [8, 5, 21], [5, 13, 21], [22, 11, 7], [21, 13, 18], [13, 0, 18], [13, 6, 0], [6, 10, 0], [10, 17, 0], [10, 23, 17], [23, 14, 17], [14, 3, 17], [14, 7, 3], [7, 11, 3], [11, 18, 3], [11, 21, 18]
];
CIRCUMRADIUS_SNUB_CUBE = sqrt((3 - TRIBONACCI) / (8 - 4 * TRIBONACCI));

// Source: https://en.wikipedia.org/wiki/Icosidodecahedron
//	side = r == 0 ? a / 2 : r / (2 * PHI);
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
	[0, +1/PHI, -(2+PHI)],  //0
	[0, -1/PHI, +(2+PHI)],  //0
	[0, -1/PHI, -(2+PHI)],  //0
	
	[+(2+PHI), 0, +1/PHI],  //0
	[+(2+PHI), 0, -1/PHI],  //0
	[-(2+PHI), 0, +1/PHI],  //0
	[-(2+PHI), 0, -1/PHI],  //0
	
	[+1/PHI, +(2+PHI), 0],  //0	
	[+1/PHI, -(2+PHI), 0],  //0	
	[-1/PHI, +(2+PHI), 0],  //0	
	[-1/PHI, -(2+PHI), 0],  //0
	
	[+1/PHI, +PHI, +2*PHI],  //0
	[+1/PHI, +PHI, -2*PHI],  //0
	[+1/PHI, -PHI, +2*PHI],  //0
	[+1/PHI, -PHI, -2*PHI],  //0
	[-1/PHI, +PHI, +2*PHI],  //0
	[-1/PHI, +PHI, -2*PHI],  //0
	[-1/PHI, -PHI, +2*PHI],  //0
	[-1/PHI, -PHI, -2*PHI],  //0
	
	[+2*PHI, +1/PHI, +PHI],  //0
	[+2*PHI, +1/PHI, -PHI],  //0
	[+2*PHI, -1/PHI, +PHI],  //0
	[+2*PHI, -1/PHI, -PHI],  //0
	[-2*PHI, +1/PHI, +PHI],  //0
	[-2*PHI, +1/PHI, -PHI],  //0
	[-2*PHI, -1/PHI, +PHI],  //0
	[-2*PHI, -1/PHI, -PHI],  //0
	
	[+PHI, +2*PHI, +1/PHI],  //0
	[+PHI, +2*PHI, -1/PHI],  //0
	[+PHI, -2*PHI, +1/PHI],  //0
	[+PHI, -2*PHI, -1/PHI],  //0
	[-PHI, +2*PHI, +1/PHI],  //0
	[-PHI, +2*PHI, -1/PHI],  //0
	[-PHI, -2*PHI, +1/PHI],  //0
	[-PHI, -2*PHI, -1/PHI],  //0
	
	[+PHI, +2, +(PHI+1)], //0
	[+PHI, +2, -(PHI+1)], //0
	[+PHI, -2, +(PHI+1)], //0
	[+PHI, -2, -(PHI+1)], //0
	[-PHI, +2, +(PHI+1)], //0
	[-PHI, +2, -(PHI+1)], //0
	[-PHI, -2, +(PHI+1)], //0
	[-PHI, -2, -(PHI+1)], //0
	
	[+(PHI+1), +PHI, +2], //0
	[+(PHI+1), +PHI, -2], //0
	[+(PHI+1), -PHI, +2], //0
	[+(PHI+1), -PHI, -2], //0
	[-(PHI+1), +PHI, +2], //0
	[-(PHI+1), +PHI, -2], //0
	[-(PHI+1), -PHI, +2], //0
	[-(PHI+1), -PHI, -2], //0
	
	[+2, +(PHI+1), +PHI], //0
	[+2, +(PHI+1), -PHI], //0
	[+2, -(PHI+1), +PHI], //0
	[+2, -(PHI+1), -PHI], //0
	[-2, +(PHI+1), +PHI], //0
	[-2, +(PHI+1), -PHI], //0
	[-2, -(PHI+1), +PHI], //0
	[-2, -(PHI+1), -PHI]  //0
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
// TODO: add these properties.
VERTICES_RHOMBICOSIDODECAHEDRON =
[

];
FACES_RHOMBICOSIDODECAHEDRON = 
[

];
CIRCUMRADIUS_RHOMBICOSIDODECAHEDRON = 1;

// Source: https://en.wikipedia.org/wiki/Truncated_icosidodecahedron
// TODO: add these properties.
VERTICES_TRUNCATED_ICOSIDODECAHEDRON =
[

];
FACES_TRUNCATED_ICOSIDODECAHEDRON = 
[

];
CIRCUMRADIUS_TRUNCATED_ICOSIDODECAHEDRON = 1;

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

// Source: https://en.wikipedia.org/wiki/Prism_(geometry)
function VERTICES_PRISM(n = 3) = 
	let (
		radius = 1 / (2 * sin(180 / n))
	)
	[for (k = [0 : 2 * n - 1]) [radius * cos(360 * floor(k / 2) / n), radius * sin(360 * floor(k / 2) / n), pow(-1, k) * 1 / 2]];
function FACES_PRISM(n = 3) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces = [for (k = [0 : n - 1]) [for (l = [1, 0, 2, 3]) (l + 2 * k) % (2 * n)]]
	) 
	concat([top_face, bottom_face], side_faces);
function CIRCUMRADIUS_PRISM(n = 3) = 1 / sin(atan(sin(180 / n))) / 2;
		
// Source: https://en.wikipedia.org/wiki/Antiprism
function VERTICES_ANTIPRISM(n = 3) =
	let (
		radius = 1 / (2 * sin(180 / n)),
		height = sqrt((cos(180 / n) - cos(360 / n)) / 2)
	)
	[for (k = [0 : 2 * n - 1]) [radius * cos(180 * k / n), radius * sin(180 * k / n), radius * pow(-1, k) * height]];
function FACES_ANTIPRISM(n = 3) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces_top = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [2 : -1 : 0]) (l + k) % (2 * n)]],
		side_faces_bottom = [for (k = [1 : 2 : 2 * n - 1]) [for (l = [0 : 2]) (l + k) % (2 * n)]]	
	)
	concat([top_face, bottom_face], side_faces_top, side_faces_bottom);
function CIRCUMRADIUS_ANTIPRISM(n = 3) = 1 / 4 * sqrt(4 + 1 / pow(sin(90 / n), 2));


/////////////
// Utility //
/////////////

// Calculates the sum of a vector (elements of the vector may also be vectors).
function sum(v) = [for (e = v) 1] * v;
	
// Calculates the mean of a vector (elements of the vector may also be vectors).
function mean(v) = sum(v) / len(v);

// Returns all edges for a set of faces (used to draw a polygon).
function get_all_edges(faces, i = 0, r = []) = delete_duplicates(let(f = faces[i]) i < len(faces) ? get_all_edges(faces, i + 1, concat(r, get_edges(f))) : r);
function get_edges(face) = [for (i = [0 : len(face) - 1]) [face[i], face[(i + 1) % len(face)]]];
// Deletes all duplicates in a vector.
// TODO: fix cyclic elements.
function delete_duplicates(v, i = 0, r = []) = let(e = v[i]) i < len(v) ? delete_duplicates(v, i + 1, (is_element(r, e) || is_element(r, cycle(e)) ? r : concat(r, [e]))) : r;
// Determines whether elem is part of vector.
function is_element(v, elem, i = 0) = let (e = v[i]) i < len(v) ? e == elem ? true : is_element(v, elem, i + 1) : false;
// Cycles the elements of v forwards once (first element goes to last position).
function cycle(v) = [for (i = [0 : len(v) - 1]) v[(i + 1) % len(v)]];
	
// Rotation for a shape pointing straight up (z-axis) to align with two points.
function rotation_to_points(p1, p2) = [-acos((p2[2] - p1[2]) / norm(p1 - p2)), 0, -atan2(p2[0] - p1[0], p2[1] - p1[1])];

function normal_vector(p1, p2, p3) = cross(p2 - p1, p3 - p1);


///////////////
// Debugging //
///////////////

// Draws a number to each polyhedral vertex for identification.
module number_vertices(vertices)
{
	scaled_vertices = [for (v = vertices) 1.15 * v];
	for (i = [0 : len(scaled_vertices) - 1])
	{
		color("Red")
			translate(scaled_vertices[i])
				text(text = str(i), halign = "center", valign = "center", size = 20);
	};
}
