/* Polyhedra Library Data: Platonic
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
*/

// Source: https://en.wikipedia.org/wiki/Tetrahedron
VERTICES_TETRAHEDRON = [
	[+1/2, 0, -1/sqrt(8)],
	[-1/2, 0, -1/sqrt(8)],
	[0, +1/2, +1/sqrt(8)],
	[0, -1/2, +1/sqrt(8)]
];
FACES_TETRAHEDRON = [
	[1, 0, 2], [0, 1, 3], [0, 3, 2], [1, 2, 3]
];
CIRCUMRADIUS_TETRAHEDRON = sqrt(3 / 8);

// Source: https://en.wikipedia.org/wiki/Cube
VERTICES_HEXAHEDRON = [
	[+1/2, +1/2, +1/2],
	[+1/2, +1/2, -1/2],
	[+1/2, -1/2, +1/2],
	[+1/2, -1/2, -1/2],
	[-1/2, +1/2, +1/2],
	[-1/2, +1/2, -1/2],
	[-1/2, -1/2, +1/2],
	[-1/2, -1/2, -1/2]
];
FACES_HEXAHEDRON = [
	[6, 2, 3, 7], [2, 6, 4, 0], [2, 0, 1, 3],
	[5, 4, 6, 7], [7, 3, 1, 5], [0, 4, 5, 1]
];
CIRCUMRADIUS_HEXAHEDRON = sqrt(3) / 2;

// Source: https://en.wikipedia.org/wiki/Octahedron
VERTICES_OCTAHEDRON = [
	[+1/sqrt(2), 0, 0],
	[-1/sqrt(2), 0, 0],
	[0, +1/sqrt(2), 0],
	[0, -1/sqrt(2), 0],
	[0, 0, +1/sqrt(2)],
	[0, 0, -1/sqrt(2)]
];
FACES_OCTAHEDRON = [
	[3, 4, 0], [4, 3, 1], [1, 2, 4], [2, 0, 4],
	[3, 0, 5], [0, 2, 5], [2, 1, 5], [1, 3, 5]
];
CIRCUMRADIUS_OCTAHEDRON = sqrt(2) / 2;

// Source: https://en.wikipedia.org/wiki/Regular_dodecahedron
VERTICES_DODECAHEDRON = [
	[+PHI/2, +PHI/2, +PHI/2],
	[+PHI/2, +PHI/2, -PHI/2],
	[+PHI/2, -PHI/2, +PHI/2],
	[+PHI/2, -PHI/2, -PHI/2],
	[-PHI/2, +PHI/2, -PHI/2],
	[-PHI/2, +PHI/2, +PHI/2],
	[-PHI/2, -PHI/2, -PHI/2],
	[-PHI/2, -PHI/2, +PHI/2],

	[0, +1/2, +PHI*PHI/2],
	[0, +1/2, -PHI*PHI/2],
	[0, -1/2, +PHI*PHI/2],
	[0, -1/2, -PHI*PHI/2],

	[+1/2, +PHI*PHI/2, 0],
	[+1/2, -PHI*PHI/2, 0],
	[-1/2, +PHI*PHI/2, 0],
	[-1/2, -PHI*PHI/2, 0],
	
	[+PHI*PHI/2, 0, +1/2],
	[-PHI*PHI/2, 0, +1/2],
	[+PHI*PHI/2, 0, -1/2],
	[-PHI*PHI/2, 0, -1/2]
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
	[0, +1/2, +PHI/2],
	[0, +1/2, -PHI/2],
	[0, -1/2, +PHI/2],
	[0, -1/2, -PHI/2],
	[+PHI/2, 0, +1/2],
	[+PHI/2, 0, -1/2],
	[-PHI/2, 0, +1/2],
	[-PHI/2, 0, -1/2],
	[+1/2, +PHI/2, 0],
	[+1/2, -PHI/2, 0],
	[-1/2, +PHI/2, 0],
	[-1/2, -PHI/2, 0]
];
FACES_ICOSAHEDRON = [
	[2, 0, 4], [0, 2, 6], [8, 4, 0], [11, 7, 6], [2, 9, 11],
	[2, 11, 6], [2, 4, 9], [3, 7, 11], [3, 11, 9], [3, 9, 5],
	[3, 5, 1], [3, 1, 7], [1, 10, 7], [1, 8, 10], [10, 8, 0],
	[10, 0, 6], [5, 9, 4], [4, 8, 5], [8, 1, 5], [10, 6, 7]
];
CIRCUMRADIUS_ICOSAHEDRON = PHI * sin(180 / 5);
