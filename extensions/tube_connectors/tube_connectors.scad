/* Polyhedral Tube Connectors
 *
 * @copyright Maikel de Vries, 2025
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Extension for the polyhedra library: creates connector pins for round tubes which together build a wire frame model of the polyhedron.
*/


include <../../polyhedra.scad>;


///////////////
// Constants //
///////////////

RENDER_EPS = 0.001;


//////////
// Pins //
//////////

// Constructs a single pin with inner and outer diameter and inner and outer height.
// Serves as a building block for the connector pin.
module round_pin(d_in, d_out, h_in, h_out)
{
	union()
	{	
		// Construct a semi sphere as the pin end.
		difference()
		{
			sphere(d = d_out);
			translate([0, 0, -d_out / 2 - h_out])
				cube([d_out, d_out, d_out], center = true);
		}
		// Add a cylinder which fits onto the tube, i.e. has the same outer radius.
		translate([0, 0, -h_out])
			cylinder(d = d_out, h = h_out);
		// Add a cylinder which fits into the tube, i.e. has the same inner radius.
		// Do this using a threaded rod which makes fitting into the tube easier.
		translate([0, 0, -h_out - h_in / 2 + RENDER_EPS])
			difference()
			{
				cylinder(d = d_in, h = h_in, center = true);
				//threaded_rod(d = d_in, l = h_in);
				//cylinder(d = max(d_in - 4, 0), h = h_in + 2 * RENDER_EPS, center = true);
			}
	}
}

// Constructs a connector pin for a point p connecting to other points.
module connector_pin(d_in, d_out, h_in, p, connect_to, min_angle)
{
	// Loop over all points to which to connect, these lie along the edges that meet in the vertex.
	for (c = connect_to)
	{
		// Calculate rotation to each connected point.
		normal = c - p;
		normal_xy = [0, 0, -1];
		r = -acos(normal * normal_xy / norm(normal));
		axis = cross(normal, normal_xy);
		// Ensure the rotation axis is defined, in case the cross product gives zero.
		r_axis = axis == [0, 0, 0] ? [1, 1, 0] : axis;
		// The outer extrusion is at least equal to the outer radius (obtuse angles).
		// This prevents overlap with other pins in the same connection.
		// It is further determined by the minimal angle between any of edges in the connection
		h_out = max(d_out, d_out / tan(min_angle / 2)) / 2;
		// Add round pin to form the connector.
		translate(p)
			rotate(r, r_axis)
				round_pin(d_in, d_out, h_in, h_out);
	}
}

// Renders a single connector pin for 3d printing purposes.
module single_connector_pin(id, pin_nr, a = 1, n = 5, m = 2, r = 0, d_in = 1, d_out = 2, h_in = 1, supports = false)
{
	vertices = polyhedron_vertices(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	faces = polyhedron_faces(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	vertex_types = get_vertex_types(vertices, faces, edges);
	vertex_types_list = get_vertex_types_list(vertex_types);
	// Determine vertex type for pin number and find a vertex in the polyhedron.
	vertex_type = vertex_types_list[pin_nr][0];
	v = search(vertex_type, vertex_types)[0];
	// Get vertex coordinate and determine connected vertices, then find the mininum connection angle.
	p = side * vertices[v];
	connecting_v = vertices_connected_to_vertex(edges, faces, v);
	connect_to = [for (c = connecting_v) side * vertices[c]];
	min_angle = min(get_vertex_angles(v, vertices, faces, edges));
	// Reconstruct angle to rotate the pin facing up in the z-direction for 3d printing.
	normal_xy = [0, 0, 1];
	r = acos(-p * normal_xy / norm(-p));
	axis = cross(-p, normal_xy);
	// Render connector pin at the center.
	rotate(r, axis)
		translate(-p)
			connector_pin(d_in, d_out, h_in, p, connect_to, min_angle);
}

// Renders all connector pins for a polyhedron.
module connector_pins(id, a = 1, n = 5, m = 2, r = 0, d_in = 1, d_out = 2, h_in = 1)
{
	vertices = polyhedron_vertices(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	faces = polyhedron_faces(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	for (v = [0: len(vertices) - 1])
	{
		// Get vertex coordinate and determine connected vertices, then find the mininum connection angle.
		p = side * vertices[v];
		connecting_v = vertices_connected_to_vertex(edges, faces, v);
		connect_to = [for (c = connecting_v) side * vertices[c]];
		min_angle = min(get_vertex_angles(v, vertices, faces, edges));
		//echo(str("v = ", v, "; connect_to = ", connecting_v, "; angles = ", get_vertex_angles(v, vertices, faces, edges)));
		connector_pin(d_in, d_out, h_in, p, connect_to, min_angle);
	}		
}


///////////
// Tubes //
///////////

// Renders all connector tubes for a polyhedron.
module connector_tubes(id, a = 1, n = 5, m = 5, r = 0, d_in = 1, d_out = 2, h_in = 1)
{
	vertices = polyhedron_vertices(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	faces = polyhedron_faces(id, n = n, m = m);
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	for (e = edges)
	{
		p1 = side * vertices[e[0]];
		p2 = side * vertices[e[1]];
		center = (p1 + p2) / 2;
		// Calculate tube length and offset if connector pins are not equal.
		min_angle1 = min(get_vertex_angles(e[0], vertices, faces, edges));
		min_angle2 = min(get_vertex_angles(e[1], vertices, faces, edges));
		h_out1 = max(d_out, d_out / tan(min_angle1 / 2)) / 2;
		h_out2 = max(d_out, d_out / tan(min_angle2 / 2)) / 2;
		tube_length = norm(p1 - p2) - h_out1 - h_out2;
		tube_offset = (h_out1 - h_out2) / 2;
		// Render the tube.
		translate(center)
			rotate(rotation_to_points(p1, p2))
				translate([0, 0, tube_offset])
					difference()
					{
						cylinder(h = tube_length, d = d_out, center = true);
						cylinder(h = tube_length + 0.01, d = d_in, center = true);
					}
	}
}


///////////////
// Functions //
///////////////

// Returns vertex types for each vertex: just the number of connections.
function get_vertex_types(vertices, faces, edges) = [for (v = [0 : len(vertices) - 1]) len(vertices_connected_to_vertex(edges, faces, v))];
// Returns a list of vertex type and the number of occurences in the polyhedron.
function get_vertex_types_list(types) = let(
		types_unique = delete_duplicates(types)
	) [for (t = types_unique) [t, len(search(t, types, num_returns_per_match = 0))]];

// Returns a list of all angles between the edges that meet in this vertex.
function get_vertex_angles(v, vertices, faces, edges) = let(
		p = vertices[v],
		connecting_v = vertices_connected_to_vertex(edges, faces, v),
		connect_to = [for (c = connecting_v) vertices[c]]
	) [for (vc = [0 : len(connect_to) - 1]) acos((connect_to[vc] - p) * (connect_to[(vc + 1) % len(connect_to)] - p) / (norm(connect_to[vc] - p) * norm(connect_to[(vc + 1) % len(connect_to)] - p)))];

// Creates a threaded rod using sinus waves without pitch, this allows for smoother fitting into tubes.
module threaded_rod(d, l)
{
	thread_depth = 0.5;
	threads_per_mm = 1;
	wave_points = [for (y = [-l/2 : 0.05 : l/2]) [(d - thread_depth + thread_depth * sin(360 * threads_per_mm * y - 45)) / 2, y]];
	points = concat([[0, -l/2]], wave_points, [[0, l/2]]);
	rotate_extrude() polygon(points);
}

// Calculate tube lengths.
function calculate_tube_lengths(side, d_out, vertices, faces, edges) = [for (e = edges) calculate_tube_length(side, d_out, vertices, faces, edges, e[0], e[1])];
function calculate_tube_length(side, d_out, vertices, faces, edges, v1, v2) = let(
		p1 = side * vertices[v1],
		p2 = side * vertices[v2],
		min_angle1 = min(get_vertex_angles(v1, vertices, faces, edges)),
		min_angle2 = min(get_vertex_angles(v2, vertices, faces, edges)),
		h_out1 = max(d_out, d_out / tan(min_angle1 / 2)) / 2,
		h_out2 = max(d_out, d_out / tan(min_angle2 / 2)) / 2
	) norm(p1 - p2) - h_out1 - h_out2;
// Returns a list of tube lengths and the number of occurences in the polyhedron.
function get_tube_lengths_list(lengths) = let(
		delta = 1e-10,
		lengths_unique = delete_duplicates_float(lengths)
	) [for (lu = lengths_unique) [lu, len([for (l = lengths) if (abs(lu - l) < delta) 1])]];

function delete_duplicates_float(v, delta = 1e-10, i = 0, r = []) = let(e = v[i]) i < len(v) ? delete_duplicates_float(v, delta, i + 1, (is_element_float(r, e, delta) ? r : concat(r, [e]))) : r;
	
function is_element_float(v, elem, delta = 1e-10, i = 0) = i < len(v) ? abs(v[i] - elem) < delta ? true : is_element_float(v, elem, delta, i + 1) : false;