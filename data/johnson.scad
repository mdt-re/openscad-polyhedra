/* Polyhedra Library Data: Johnson
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
*/


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

// Source: https://en.wikipedia.org/wiki/Triangular_cupola
VERTICES_TRIANGULAR_COPULA = [
	[+1/2, +sqrt(3)/2, 0],
	[+1/2, -sqrt(3)/2, 0],
	[-1/2, +sqrt(3)/2, 0],
	[-1/2, -sqrt(3)/2, 0],
	[+1, 0, 0],
	[-1, 0, 0],
	
	[+1/2, +1/sqrt(12), sqrt(2/3)],
	[-1/2, +1/sqrt(12), sqrt(2/3)],
	[0, -1/sqrt(3), sqrt(2/3)]
];
FACES_TRIANGULAR_COPULA = [
	[0, 2, 5, 3, 1, 4], [6, 8, 7],
	[0, 6, 7, 2], [1, 8, 6, 4], [7, 8, 3, 5],
	[8, 1, 3], [7, 5, 2], [6, 0, 4]
];
CIRCUMRADIUS_TRIANGULAR_COPULA = 1;

// Source: https://en.wikipedia.org/wiki/Square_cupola
VERTICES_SQUARE_COPULA = [
	[+(1 + sqrt(2))/2, +1/2, 0],
	[+(1 + sqrt(2))/2, -1/2, 0],
	[-(1 + sqrt(2))/2, +1/2, 0],
	[-(1 + sqrt(2))/2, -1/2, 0],
	[+1/2, +(1 + sqrt(2))/2, 0],
	[+1/2, -(1 + sqrt(2))/2, 0],
	[-1/2, +(1 + sqrt(2))/2, 0],
	[-1/2, -(1 + sqrt(2))/2, 0],

	[+1/sqrt(2), 0, +1/sqrt(2)],
	[-1/sqrt(2), 0, +1/sqrt(2)],
	[0, +1/sqrt(2), +1/sqrt(2)],
	[0, -1/sqrt(2), +1/sqrt(2)]
];
FACES_SQUARE_COPULA = [
	[10, 8, 11, 9], [4, 6, 2, 3, 7, 5, 1, 0],
	[8, 10, 4, 0], [10, 9, 2, 6], [9, 11, 7, 3], [11, 8, 1, 5],
	[1, 8, 0], [4, 10, 6], [2, 9, 3], [7, 11, 5]
];
CIRCUMRADIUS_SQUARE_COPULA = sqrt(1 + sqrt(2) / 2);

// Source: https://en.wikipedia.org/wiki/Pentagonal_cupola
VERTICES_PENTAGONAL_COPULA = [
	[+1, +1 * sqrt(3 + 4 * PHI), 0],
	[+1, -1 * sqrt(3 + 4 * PHI), 0],
	[-1, +1 * sqrt(3 + 4 * PHI), 0],
	[-1, -1 * sqrt(3 + 4 * PHI), 0],
	[+1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],
	[+1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],
	[-1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],
	[-1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],
	[+1 * 2 * PHI, 0, 0],
	[-1 * 2 * PHI, 0, 0],

	[0, +sqrt((10 + 2 * sqrt(5)) / 5), +2 * sqrt((3 - PHI) / 5)],
	[+1 * PHI, +sqrt((5 - sqrt(5)) / 10), +2 * sqrt((3 - PHI) / 5)],
	[-1 * PHI, +sqrt((5 - sqrt(5)) / 10), +2 * sqrt((3 - PHI) / 5)],
	[+1, -sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((3 - PHI) / 5)],
	[-1, -sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((3 - PHI) / 5)],
] / 2;
FACES_PENTAGONAL_COPULA = [
	[0, 2, 6, 9, 7, 3, 1, 5, 8, 4], [10, 11, 13, 14, 12],
	[4, 8, 11], [5, 1, 13], [3, 7, 14], [9, 6, 12], [2, 0, 10],
	[2, 10, 12, 6], [0, 4, 11, 10], [8, 5, 13, 11], [1, 3, 14, 13], [7, 9, 12, 14]
];
CIRCUMRADIUS_PENTAGONAL_COPULA = PHI;
		
// Source: https://en.wikipedia.org/wiki/Pentagonal_rotunda
VERTICES_PENTAGONAL_ROTUNDA = [
	[+1, +1 * sqrt(3 + 4 * PHI), 0],
	[+1, -1 * sqrt(3 + 4 * PHI), 0],
	[-1, +1 * sqrt(3 + 4 * PHI), 0],
	[-1, -1 * sqrt(3 + 4 * PHI), 0],
	[+1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],
	[+1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],
	[-1 * PHI * PHI, +1 * sqrt(2 + PHI), 0],
	[-1 * PHI * PHI, -1 * sqrt(2 + PHI), 0],
	[+1 * 2 * PHI, 0, 0],
	[-1 * 2 * PHI, 0, 0],

	[0, -sqrt((10 + 2 * sqrt(5)) / 5), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],
	[+1, +sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],
	[-1, +sqrt((5 + 2 * sqrt(5)) / 5), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],
	[+1 * PHI, -sqrt((5 - sqrt(5)) / 10), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],
	[-1 * PHI, -sqrt((5 - sqrt(5)) / 10), +2 * sqrt((5 + 2 * sqrt(5)) / 5)],

	[0, +2 * sqrt((5 + 2 * sqrt(5)) / 5), +sqrt((10 + 2 * sqrt(5)) / 5)],
	[+1 * PHI, -sqrt((25 + 11 * sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)],
	[-1 * PHI, -sqrt((25 + 11 * sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)],
	[+1 * PHI * PHI, +sqrt((5 + sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)],
	[-1 * PHI * PHI, +sqrt((5 + sqrt(5)) / 10), +sqrt((10 + 2 * sqrt(5)) / 5)]
] / 2;
FACES_PENTAGONAL_ROTUNDA = [
	[0, 2, 6, 9, 7, 3, 1, 5, 8, 4], [10, 14, 12, 11, 13],
	[2, 15, 12, 19, 6], [9, 19, 14, 17, 7], [3, 17, 10, 16, 1], [5, 16, 13, 18, 8], [4, 18, 11, 15, 0],
	[0, 15, 2], [6, 19, 9], [7, 17, 3], [1, 16, 5], [8, 18, 4],	[10, 17, 14], [14, 19, 12], [12, 15, 11], [11, 18, 13], [13, 16, 10]
];
CIRCUMRADIUS_PENTAGONAL_ROTUNDA = PHI;

// Source: https://en.wikipedia.org/wiki/Snub_disphenoid
CONSTANT_SNUB_DISPHENOID_Q = 0.1690222294; // Root of 2 x^3 + 11 x^2 + 4 x - 1 = 0
CONSTANT_SNUB_DISPHENOID_R = sqrt(CONSTANT_SNUB_DISPHENOID_Q) / 2;
CONSTANT_SNUB_DISPHENOID_S = sqrt((1 - CONSTANT_SNUB_DISPHENOID_Q) / (2 * CONSTANT_SNUB_DISPHENOID_Q)) / 2;
CONSTANT_SNUB_DISPHENOID_T = 4 * CONSTANT_SNUB_DISPHENOID_R * CONSTANT_SNUB_DISPHENOID_S;
VERTICES_SNUB_DISPHENOID = [
	[+CONSTANT_SNUB_DISPHENOID_T, CONSTANT_SNUB_DISPHENOID_R, 0],
	[-CONSTANT_SNUB_DISPHENOID_T, CONSTANT_SNUB_DISPHENOID_R, 0],
	[0, -CONSTANT_SNUB_DISPHENOID_R, +CONSTANT_SNUB_DISPHENOID_T],
	[0, -CONSTANT_SNUB_DISPHENOID_R, -CONSTANT_SNUB_DISPHENOID_T],
	[+1/2, -CONSTANT_SNUB_DISPHENOID_S, 0],
	[-1/2, -CONSTANT_SNUB_DISPHENOID_S, 0],
	[0, CONSTANT_SNUB_DISPHENOID_S, +1/2],
	[0, CONSTANT_SNUB_DISPHENOID_S, -1/2],
];
FACES_SNUB_DISPHENOID = [
	[0, 2, 6], [0, 4, 2], [0, 3, 4], [0, 7, 3], [0, 6, 7],
	[1, 2, 5], [1, 5, 3], [1, 3, 7], [1, 7, 6], [1, 6, 2],
	[2, 4, 5], [3, 5, 4]
];
CIRCUMRADIUS_SNUB_DISPHENOID = sqrt(1/4 + pow(CONSTANT_SNUB_DISPHENOID_S, 2));


// Source: https://en.wikipedia.org/wiki/Bilunabirotunda
VERTICES_BILUNABIROTUNDA = [
	[0, 0, +PHI / 2],
	[0, 0, -PHI / 2],
	
	[+(PHI + 1) / 2, +1/2],
	[+(PHI + 1) / 2, -1/2],
	[-(PHI + 1) / 2, +1/2],
	[-(PHI + 1) / 2, -1/2],
	
	[+1/2, +PHI / 2, +1/2],
	[+1/2, +PHI / 2, -1/2],
	[+1/2, -PHI / 2, +1/2],
	[+1/2, -PHI / 2, -1/2],
	[-1/2, +PHI / 2, +1/2],
	[-1/2, +PHI / 2, -1/2],
	[-1/2, -PHI / 2, +1/2],	
	[-1/2, -PHI / 2, -1/2],
];
FACES_BILUNABIROTUNDA = [
	[0, 8, 12], [0, 10, 6], [1, 13, 9], [1, 7, 11], [2, 6, 7], [3, 9, 8], [4, 11, 10], [5, 12, 13],
	[6, 10, 11, 7], [8, 9, 13, 12],
	[0, 6, 2, 3, 8], [0, 12, 5, 4, 10], [1, 11, 4, 5, 13], [1, 9, 3, 2, 7],
];
CIRCUMRADIUS_BILUNABIROTUNDA = 1; // TODO
