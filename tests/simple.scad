/* Tests: Simple 
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Tests for polyhedra library: one polyhedron.
*/

use <../polyhedra.scad>;


// General constants.
ERROR_MARGIN = 1e-14;


// Polyhedron to test.
poly = "square_pyramid";
poly_n = 5;
poly_m = 2;

// Display all polyhedra for visual checks.
radius = 80;
sphere_fn = 200;
color("DimGray")
difference()
{
	draw_polyhedron(poly, r = radius, n = poly_n, m = poly_m);
	faces_center = polyhedron_faces_center(poly);
	faces_orientation = polyhedron_faces_orientation(poly);
	for (i = [0 : len(faces_center) - 1])
		{
			translate(radius / circumradius_factor(poly) * faces_center[i])
				rotate(faces_orientation[i][0], faces_orientation[i][1])
					cylinder(r = radius / 8, h = radius / 8, center = true);
		}
}
//color("LightSteelBlue", 0.2) sphere(radius, $fn = sphere_fn);

// Debugging
number_vertices(poly, r = radius, n = poly_n, m = poly_m);
number_faces(poly, r = radius, n = poly_n, m = poly_m);

// Unit tests:
// - edge length (a) equals unity.
// - circumradius factor.
vertices = polyhedron_vertices(poly);
faces = polyhedron_faces(poly);
edges = polyhedron_edges(poly);
echo(str("checking polyhedron: ", poly));
echo(str("F = ", len(faces), " V = ", len(vertices), " E = ", len(edges)));
// Calculate average edge length.
echo([for (e = edges) norm(vertices[e[0]] - vertices[e[1]])]);
echo(mean([for (e = edges) norm(vertices[e[0]] - vertices[e[1]])]));

// Check edges.
for (e = edges)
{
	v1 = vertices[e[0]];
	v2 = vertices[e[1]];
	// Check if edges are unit length.
	if (abs(norm(v1 - v2) - 1) > ERROR_MARGIN)
		echo(str("edge (", e, ") not unit length for ", poly, " length = ", norm(v1 - v2))); 
}

// Check vertices.
for (v = vertices)
{
	if (abs(norm(v) - circumradius_factor(poly)) > ERROR_MARGIN)
		echo(str("circumradius factor is off for ", poly, ": ", norm(v), " != ", circumradius_factor(poly)));
}
