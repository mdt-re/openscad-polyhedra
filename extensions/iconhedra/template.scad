/* Iconhedra - Template
 *
 * For a general polyhedron to be iconized use this template and provide the file
 * to the python script.
 *
 * @copyright 2025 Maikel de Vries
 * @license GPL-3.0
 */

points = [
	[x, y, z],
	...
];
faces = [
    [0, 1, 2, 3],
	...
];

echo(str("<VERTICES>", points, "<VERTICES>")); 
echo(str("<FACES>", faces, "<FACES>"));
