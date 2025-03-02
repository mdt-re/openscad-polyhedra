/* Polyhedra Library Data: Zonohedra
 *
 * @copyright Maikel de Vries, 2024
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
*/


// Source: https://en.wikipedia.org/wiki/Bilinski_dodecahedron
VERTICES_BILINSKI_DODECAHEDRON = [
	[0, +1, +1],
	[0, +1, -1],
	[0, -1, +1],
	[0, -1, -1],
	[+PHI, 0, +PHI],
	[+PHI, 0, -PHI],
	[-PHI, 0, +PHI],
	[-PHI, 0, -PHI],
	[+PHI, +1, 0],
	[+PHI, -1, 0],
	[-PHI, +1, 0],
	[-PHI, -1, 0],
	[0, 0, +PHI * PHI],
	[0, 0, -PHI * PHI]
] / sqrt(2 + PHI);		
FACES_BILINSKI_DODECAHEDRON = [
	[0, 10, 1, 8], [2, 9, 3, 11], [0, 12, 6, 10], [0, 8, 4, 12], [1, 10, 7, 13], [1, 13, 5, 8], [2, 12, 4, 9], [2, 11, 6, 12], [3, 9, 5, 13], [3, 13, 7, 11], [4, 8, 5, 9], [6, 11, 7, 10]
];
CIRCUMRADIUS_BILINSKI_DODECAHEDRON = pow(PHI, 2);
		
// Source: https://en.wikipedia.org/wiki/Elongated_dodecahedron
// Source: https://www.wolframalpha.com/input?i=elongated+dodecahedron+vertex+coordinates
VERTICES_ELONGATED_DODECAHEDRON = [
	[0, 0, +3/2],
	[0, 0, -3/2],
	
	[+sqrt(3) / 2, 0, +1],	
	[+sqrt(3) / 2, 0, -1],
	[-sqrt(3) / 2, 0, +1],
	[-sqrt(3) / 2, 0, -1],
	[0, +sqrt(3) / 2, +1],	
	[0, +sqrt(3) / 2, -1],
	[0, -sqrt(3) / 2, +1],
	[0, -sqrt(3) / 2, -1],
	
	[+sqrt(3) / 2, +sqrt(3) / 2, +1/2],
	[+sqrt(3) / 2, +sqrt(3) / 2, -1/2],
	[+sqrt(3) / 2, -sqrt(3) / 2, +1/2],
	[+sqrt(3) / 2, -sqrt(3) / 2, -1/2],
	[-sqrt(3) / 2, +sqrt(3) / 2, +1/2],
	[-sqrt(3) / 2, +sqrt(3) / 2, -1/2],
	[-sqrt(3) / 2, -sqrt(3) / 2, +1/2],
	[-sqrt(3) / 2, -sqrt(3) / 2, -1/2]
];		
FACES_ELONGATED_DODECAHEDRON = [
	[0, 6, 10, 2], [0, 2, 12, 8], [0, 8, 16, 4], [0, 4, 14, 6], [1, 5, 17, 9], [1, 9, 13, 3], [1, 3, 11, 7], [1, 7, 15, 5],
	[2, 10, 11, 3, 13, 12], [4, 16, 17, 5, 15, 14], [6, 14, 15, 7, 11, 10], [8, 12, 13, 9, 17, 16]
];
CIRCUMRADIUS_ELONGATED_DODECAHEDRON = pow(PHI, 2);

// Source: https://en.wikipedia.org/wiki/Rhombic_icosahedron
// Source: https://www.wolframalpha.com/input?i=rhombic+icosahedron+vertex+coordinates
CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS = sqrt(1 / 10 * (5 + sqrt(5)));
CONSTANT_RHOMBIC_ICOSAHEDRON_MINUS = sqrt(1 / 10 * (5 - sqrt(5)));
VERTICES_RHOMBIC_ICOSAHEDRON = [
	[0, 0, +sqrt(5) / 2],
	[0, 0, -sqrt(5) / 2],
	[+1 + 1 / sqrt(5), 0, -1 / sqrt(20)],
	[-1 - 1 / sqrt(5), 0, +1 / sqrt(20)],
	[+ 2 / sqrt(5), 0, +3 / sqrt(20)],
	[- 2 / sqrt(5), 0, -3 / sqrt(20)],
	
	[-1 / sqrt(5), +sqrt(1 + 2 / sqrt(5)), +1 / sqrt(20)],
	[-1 / sqrt(5), -sqrt(1 + 2 / sqrt(5)), +1 / sqrt(20)],
	[+1 / sqrt(5), -sqrt(1 + 2 / sqrt(5)), -1 / sqrt(20)],
	[+1 / sqrt(5), +sqrt(1 + 2 / sqrt(5)), -1 / sqrt(20)],
	
	[-1 / 10 * (5 + sqrt(45)), -CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, -1 / sqrt(20)],
	[-1 / 10 * (5 + sqrt(45)), +CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, -1 / sqrt(20)],
	
	[-1 / 10 * (5 + sqrt(5)), -CONSTANT_RHOMBIC_ICOSAHEDRON_MINUS, +3 / sqrt(20)],
	[-1 / 10 * (5 + sqrt(5)), sqrt(2 / (5 + sqrt(5))), +3 / sqrt(20)],
	
	[-1 / 10 * (5 - sqrt(5)), -CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, -3 / sqrt(20)],
	[-1 / 10 * (5 - sqrt(5)), +CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, -3 / sqrt(20)],
	
	[+1 / 10 * (5 - sqrt(5)), -CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, 3 / sqrt(20)],
	[+1 / 10 * (5 - sqrt(5)), +CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, 3 / sqrt(20)],
	
	[+1 / 10 * (5 + sqrt(5)), -CONSTANT_RHOMBIC_ICOSAHEDRON_MINUS, -3 / sqrt(20)],
	[+1 / 10 * (5 + sqrt(5)), sqrt(2 / (5 + sqrt(5))), -3 / sqrt(20)],
	
	[+1 / 10 * (5 + sqrt(45)), -CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, 1 / sqrt(20)],
	[+1 / 10 * (5 + sqrt(45)), +CONSTANT_RHOMBIC_ICOSAHEDRON_PLUS, 1 / sqrt(20)],
];		
FACES_RHOMBIC_ICOSAHEDRON = [
	[0, 4, 20, 16], [0, 16, 7, 12], [0, 12, 3, 13], [0, 13, 6, 17], [0, 17, 21, 4],
	[1, 5, 10, 14], [1, 14, 8, 18], [1, 18, 2, 19], [1, 19, 9, 15], [1, 15, 11, 5],
	[2, 20, 4, 21], [18, 8, 20, 2], [8, 7, 16, 20], [14, 10, 7, 8], [10, 3, 12, 7], [5, 11, 3, 10], [11, 6, 13, 3], [15, 9, 6, 11], [9, 21, 17, 6], [19, 2, 21, 9]
];
CIRCUMRADIUS_RHOMBIC_ICOSAHEDRON = pow(PHI, 2);

// Source: https://en.wikipedia.org/wiki/Rhombic_enneacontahedron

// Source: https://en.wikipedia.org/wiki/Rhombic_hexecontahedron