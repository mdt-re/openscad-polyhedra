/* Polyhedral Tube Connectors
 *
 * @copyright Maikel de Vries, 2025
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Extension for the polyhedra library: creates connector pins for round tubes which together build a wire frame model of the polyhedron.
*/


use <tube_connectors.scad>;


//////////////
// Settings //
//////////////

// Polyhedron for which to construct connectors, the radius specifies where the center of the tubes meet.
poly = "snub_dodecahedron";
poly_n = 5;
poly_m = 2;
radius = 200;
// Render accuracy: use a high value (>= 32) when rendering for a 3d print.
$fn = 32;
// Inner radius of the tube.
d_inner = 6;
// Outer radius of the tube.
d_outer = 8;
// Depth to which the connector pin inserts into the tube, similar to inner radius of the tube should work fine.
pin_depth = 6;
// Render all the pins to view the model [disable to create an stl file for 3d printing].
render_pins = true;
// Render all the tubes to view the model [disable to create an stl file for 3d printing].
render_tubes = true;
// Geometries may require multiple different pins, this renders a single pin for 3d printing, first pin index equals zero, render_pins and render_tubes must be deactivated.
render_pin_nr = 0;
// Render supports for 3d printing to enhance sticking of these small parts to the print bed.
// TODO: not yet implemented.
render_supports = true;
// Renders a hole into the connector pin, such that a power cable can be placed in the polyhedron structure for lighting purposes.
cable_diameter = 0;





///////////////
// Rendering //
///////////////

// Print relevant data for model construction.
vertices = polyhedron_vertices(poly, n = poly_n, m = poly_m);
edges = polyhedron_edges(poly, n = poly_n, m = poly_m);
faces = polyhedron_faces(poly, n = poly_n, m = poly_m);
side = radius / circumradius_factor(poly, n = poly_n, m = poly_m);
// Get connector pin data.
vertex_types = get_vertex_types(vertices, faces, edges);
vertex_types_list = get_vertex_types_list(vertex_types);
echo(str("details for: ", poly));
echo(str("total number of pins: ", len(vertices)));
for (n = [0 : len(vertex_types_list) - 1])
{
	type = vertex_types_list[n];
	echo(str(" - ", type[1], " pins with ", type[0], " connections (render_pin_nr = ", n,")"));
}
// Get tube data.
tube_lengths = calculate_tube_lengths(side, d_outer, vertices, faces, edges);
tube_lengths_list = get_tube_lengths_list(tube_lengths);
echo(str("total number of tubes: ", len(edges)));
for (n = [0 : len(tube_lengths_list) - 1])
{
	length = tube_lengths_list[n];
	echo(str(" - ", length[1], " tubes with length = ", length[0], " mm"));
}

// Render all pins.
if (render_pins)
{
	color("Cyan", 1)
		connector_pins(id = poly, n = poly_n, m = poly_m, r = radius, d_in = d_inner, d_out = d_outer, h_in = pin_depth);
}
// Render all tubes.
if (render_tubes)
{
	color("Silver", 1)
		connector_tubes(id = poly, n = poly_n, m = poly_m, r = radius, d_in = d_inner, d_out = d_outer, h_in = pin_depth);
}

// Render a single pin according to the specified pin number.
if (!render_pins && ! render_pins)
{
	assert(render_pin_nr >= 0 && render_pin_nr < len(vertex_types_list), str("render_pin_nr is not valid, must be between 0 and ", len(vertex_types_list) - 1));
	color("Cyan", 1)
		difference()
		{
			single_connector_pin(id = poly, n = poly_n, m = poly_m, pin_nr = render_pin_nr, r = radius, d_in = d_inner, d_out = d_outer, h_in = pin_depth, supports = render_supports);
			if (cable_diameter > 0)
				cylinder(d = cable_diameter, h = 1000, center = true);
		}
}