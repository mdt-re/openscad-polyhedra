/* Polyhedral Graphs
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Usage documentation:
 *  Include the example by using it:
 *   use <polyhedral_graphs.scad>;
 *
 *  draw_polyhedron(id, a = 1, n = 5, m = 2, r = 0, th = 1, xi = 1)
 *   id:  the name of the polyhedron
 *   a:   [optional] the length of the base edge
 *   n:   [optional] only for regular n-gon polyhedra; number of edges for the base n-gon
 *   m:   [optional] only for regular star n-gon polyhedra; m completes the Schläfli symbol {n/m}
 *   r:   [optional] radius of the circumscribed sphere (overwrites a if non-zero)
 *   th:  [optional] thickness of the graph lines
 *   xi:  [optional] projection point distance (1 + xi) to the center
 *
 *
 * Polyhedral graphs for polyhedra. Based on:
 * - https://en.wikipedia.org/wiki/Polyhedral_graph
 * - https://en.wikipedia.org/wiki/Schlegel_diagram
 * - https://en.wikipedia.org/wiki/Platonic_graph
 * - https://en.wikipedia.org/wiki/Archimedean_graph
*/

// TODO: Consistent rotation of image on each of the faces.
// TODO: Round the edges and vertex corners.
// TODO: Draw something on the edge instead of text.


use <../../polyhedra.scad>;


////////////////////
// Graph Creation //
////////////////////

// Produces a 2D polyhedral graph for the given polyhedron (id).
// Specify the side length (a) and thickness (th). The Schlegel projection
// point is chosen at a distance (1 + xi) from the center, and the face is
// specified using the number (face_nr) [both optional].
module draw_polyhedral_graph(id, a = 1, n = 5, m = 2, r = 0, th = 1, xi = undef, face_nr = undef)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("polyhedral_graph: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	side = r == 0 ? a : r / circumradius_factor(id, n = n, m = m);
	vertices = side * polyhedron_vertices(id, n = n, m = m);
	edges = polyhedron_edges(id, n = n, m = m);
	faces = polyhedron_faces(id, n = n, m = m);
	
	// Set projection face to a face with max number of vertices.
	face_type = max(get_face_types(faces));
	face_type_nr = search(face_type, [for (f = faces) len(f)])[0];
	projection_face_nr = is_undef(face_n) ? face_type_nr : face_nr;
	projection_face = faces[projection_face_nr];
	
	// Calculate the projection plane from the projection face.
	projection_plane = [for (f = projection_face) vertices[f]];
	projection_center = side * polyhedron_faces_center(id, n = n, m = m)[projection_face_nr];
	normal_plane = plane_orthonormal(projection_plane);
	
	// Locate projection point, extend face center by a factor two.
	other_faces = faces_connected_to_face(edges, faces, projection_face);
	max_dihedral_angle = max([for (f = other_faces) dihedral_angle(vertices, projection_face, f)]);
	radius_factor = polyhedron_faces_inradius(id, n = n, m = m)[projection_face_nr];
	xi_max = abs(radius_factor * tan(max(180 - max_dihedral_angle, 0)));
	
	projection_factor = is_undef(xi) ? xi_max / 2 : xi;
	p_projection = (1 + projection_factor * side / norm(projection_center)) * projection_center;
	// Calculate the projected vertices.
	projected_vertices = [for (v = [0 : len(vertices) - 1])  line_plane_intersection(vertices[v], p_projection, projection_center, normal_plane)];
	// Transform the coordinates to 2D by projecting on the projection face.
	projection_plane_centered = [for (p = projection_plane) p - projection_center];
	ex = projection_plane_centered[0] / norm(projection_plane_centered[0]);
	ey = cross(ex, normal_plane);
	projected_vertices_2d = [for (p = projected_vertices) [ex * p, ey * p]];
	
	// Draw the projected vertices in 2D.
	for (p = projected_vertices_2d)
		translate(p)
			circle(d = th, $fn = 32);
	// Draw the projected edges in 2D.
	for (e = edges)
	{
		p1 = projected_vertices_2d[e[0]];
		p2 = projected_vertices_2d[e[1]];
		line(p1, p2, th = th);
	}
	
	// Display edge's lengths.
	for (e = edges)
	{
		p1 = projected_vertices_2d[e[0]];
		p2 = projected_vertices_2d[e[1]];
		translate((p1 + p2) / 2)
			rotate(angle_2d(p2 - p1, [1, 0]))
				color("Red")
					text(str(round(norm(p2 - p1))), size = th, halign = "center", valign = "bottom");
	}
	
	// Display edge-vertex-edge angles.
	for (v = [0 : len(vertices) - 1])
	{
		c_edges = edges_connected_to_vertex(edges, v);
		for (e = [0 : len(c_edges) - 1])
		{
			e1 = [v, other_element(c_edges[e], v)];
			e2 = [v, other_element(c_edges[(e + 1) % len(c_edges)], v)];
			e1p1 = projected_vertices_2d[e1[0]];
			e1p2 = projected_vertices_2d[e1[1]];
			e2p1 = projected_vertices_2d[e2[0]];
			e2p2 = projected_vertices_2d[e2[1]];
			angle = angle_2d(e1p2 - e1p1, e2p2 - e2p1);
			translate(projected_vertices_2d[v] + 1/5*(e1p1 + e1p2 + e2p1 + e2p2 - 4 * projected_vertices_2d[v]) / 2)
				color("Blue")
					text(str(round(angle)), size = th, halign = "center", valign = "center");
		}		
	}
	
	
	// Print total edge length.
	line_lengths = [for (e = edges) norm(projected_vertices_2d[e[0]] - projected_vertices_2d[e[1]])];
	echo(str("total length of lines: ", sum(line_lengths)));
}

// Draws a line between two points (p1, p2) with given thickness (th).
module line(p1, p2, th)
{
	delta = p2 - p1;
	perp = [-delta[1], delta[0]];
	perp_th = 1/2 * th * perp / norm(perp);
	polygon([p1 + perp_th, p2 + perp_th, p2 - perp_th, p1 - perp_th]);	
}

// Returns the angle between two vectors.
//function angle_2d(p1, p2) = atan2(p2[1] - p1[1], p2[0] - p1[0]);

function angle_2d(p1, p2) = acos(p1 * p2 / norm(p1) / norm(p2));


//////////////////////
// Polyhedral Graph //
//////////////////////

//translate([0, 0]) draw_polyhedral_graph(id = "snub_dodecahedron_laevo", r = 400, th = 2);
//translate([0, 400]) draw_polyhedral_graph(id = "snub_dodecahedron_dextro", r = 400, th = 2);

draw_polyhedral_graph(id = "dodecahedron", a = 100, th = 2);