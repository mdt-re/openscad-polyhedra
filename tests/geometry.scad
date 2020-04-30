/* Tests: Geometry 
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Tests for polyhedra library: geometrical properties.
*/

use <../polyhedra.scad>;


// General constants.
ERROR_MARGIN = 1e-14;


// Polyhedra to test.
list = list_polyhedra();


// Display all polyhedra for visual checks.
radius = 4;
sphere_fn = 50;
cube_size = ceil(pow(len(list), 1/3));
for (x = [0 : cube_size - 1], y = [0 : cube_size - 1], , z = [0 : cube_size - 1])
{
	k = cube_size * cube_size * z + cube_size * y + x;
	if (k < len(list))
	{
		translate([6 * radius * x, 6 * radius * y, 6 * radius * z])
		{
			color("DimGray")
				draw_polyhedron(list[k], r = radius);
			color("LightSteelBlue", 0.2)
				sphere(radius, $fn = sphere_fn);
		}
	}
}


// Check all polyhedra for general properties:
// - edge length (a) equals unity.
// - circumradius factor.
for (poly = list)
{
	vertices = polyhedron_vertices(poly);
	faces = polyhedron_faces(poly);
	edges = polyhedron_edges(poly);
	echo(str("checking polyhedron: ", poly));
	echo(str("F = ", len(faces), " V = ", len(vertices), " E = ", len(edges)));
	
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
}
