/* Polyhedra Library Data: Platonic
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
*/


// Source: https://en.wikipedia.org/wiki/Small_stellated_dodecahedron
VERTICES_SMALL_STELLATED_DODECAHEDRON = 
	let (
		stellated_intersections = [
			[0, 11, 4, 6],
			[0, 9, 2, 8],
			[0, 5, 4, 10],
			[0, 1, 8, 6],
			[0, 7, 6, 8],
			[3, 2, 7, 9],
			[3, 6, 7, 9],
			[3, 10, 1, 11],
			[3, 8, 7, 5],
			[3, 4, 5, 11],
			[1, 4, 3, 8],
			[1, 0, 10, 5],
			[1, 6, 8, 7],
			[2, 7, 11, 0],
			[2, 3, 6, 9],
			[2, 5, 11, 4],
			[4, 1, 8, 9],
			[4, 3, 2, 5],
			[6, 3, 10, 11],
			[6, 1, 10, 11]
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
