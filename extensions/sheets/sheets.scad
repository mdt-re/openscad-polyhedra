/* Polyhedral Sheets
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Extension for the polyhedra library: creates a polyhedron model out of sheets of material using certain types of edge connections.
 * 
 * The following functions are available:
 * - draw_sheets_3d(id, n = 5, m = 2, r = 1, th = 1, debug = false)
 * - draw_sheets_2d(id, n = 5, m = 2, r = 1, th = 1)
 * - info_sheets(id, n = 5, m = 2, r = 1, th = 1)
 * where the parameters are:
 * - id (string) | the id of the polyhedron.
 * - n (num)     | only for regular n-gon polyhedra; number of edges for the base n-gon.
 * - m (num)     | only for regular star n-gon polyhedra; m completes the Schläfli symbol {n/m}.
 * - r (num)     | radius of the circumscribed sphere.
 * - th (num)    | thickness of the sheets.
*/


use <../polyhedra.scad>;


///////////////
// Constants //
///////////////

RENDER_EPS = 0.001;


//////////
// Main //
//////////

// Draws the sheets of the polyhedron in its usual 3d structure for visualization purposes.
module draw_sheets_3d(id, a = 1, n = 5, m = 2, r = 0, th = 1, face_list = undef, face_colors = undef, debug = false)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_sheets_3d: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id = id, n = n, m = m);
	edges = polyhedron_edges(id = id, n = n, m = m);
	faces = polyhedron_faces(id = id, n = n, m = m);
	c_factor = circumradius_factor(id = id, n = n, m = m);
	
	// Draw sheets for all requested faces.
	draw_faces = is_undef(face_list) ? [0 : len(faces) - 1] : face_list;
	draw_colors = is_undef(face_colors) ? [for (l = [0 : len(faces) - 1]) "Gold"] : face_colors;
	for (nf = draw_faces)
	{
		// Add a slight gap between each face for visualization purposes.
		face_center = r / c_factor * polyhedron_faces_center(id = id, n = n, m = m)[nf];
		delta = 2;
		color(draw_colors[nf])
		translate(delta * face_center / r)
			draw_model_sheet(id = id, face_n = nf, a = a, n = n, m = m, r = r, th = th);

	}
	
	// Debugging information.
	if (debug)
	{
		number_faces(id = id, r = r + 10);	
	}
}


// Draws the sheets of the polyhedron on a 2d surface for construction purposes.
module draw_sheets_2d(id, a = 1, n = 5, m = 2, r = 0, th = 1, face_list = undef, debug = false)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("draw_sheets_2d: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id = id, n = n, m = m);
	edges = polyhedron_edges(id = id, n = n, m = m);
	faces = polyhedron_faces(id = id, n = n, m = m);
	c_factor = circumradius_factor(id = id, n = n, m = m);
	
	// Draw sheets for all requested faces.
	draw_faces = is_undef(face_list) ? [for (i = [0 : len(faces) - 1]) i] : face_list;
	echo(draw_faces);
	for (nf = draw_faces)
	{
		// Determine rotation of the sheet to the xy-plane.
		face_center = r / c_factor * polyhedron_faces_center(id = id, n = n, m = m)[nf];
		face_normal = normal_vector(vertices[faces[nf][0]], vertices[faces[nf][1]], vertices[faces[nf][2]]);
		normal_xy = [0, 0, 1];
		// For faces that are aligned with the xy-plane a rotation around the x-axis is done to align them.
		face_aligned = face_normal == normal_xy || face_normal == -normal_xy;
		rot = face_aligned ? (face_normal == normal_xy ? 180 : 0) : acos(-face_normal * normal_xy / norm(-face_normal));
		axis = face_aligned ? [1, 0, 0] : cross(-face_normal, normal_xy);
		// Locate the sheets in a square grid.
		ni = search(nf, draw_faces)[0];
		echo(nf, draw_faces, ni);
		x = ni % ceil(sqrt(len(draw_faces)));
		y = floor(ni / ceil(sqrt(len(draw_faces))));
		d = 3/2 * r;
		// Draw the sheet and rotate it to the xy-plane, then project to the xy-plane by a z=0 cut.
		difference()
		{
			projection(cut = true)
				translate([d * x, d * y, RENDER_EPS])
					rotate(rot, axis)
						translate(-face_center)
							draw_model_sheet(id = id, face_n = nf, a = a, n = n, m = m, r = r, th = th);
			if (debug)
			{
				// Number the sheet.
				translate([d * x, d * y])
					text(str(nf), halign = "center", valign = "center",  size = 10);
			}
		}
	}
	// TODO: Add numbering and bevel angles to the 2D sheets for easier processing.
}

module info_sheets(id, a = 1, n = 5, m = 2, r = 0, th = 1, face_list = undef)
{
	// Check if polyhedron id exists.
	assert(is_element(list_polyhedra(), id), str("info_sheets: ", id, " is not a valid polyhedron."));
	// Get polyhedron data.
	vertices = polyhedron_vertices(id = id, n = n, m = m);
	edges = polyhedron_edges(id = id, n = n, m = m);
	faces = polyhedron_faces(id = id, n = n, m = m);
	c_factor = circumradius_factor(id = id, n = n, m = m);
	
	echo(str("Construction data for ", id, " with ", len(faces), " faces:"));
	echo(str("All face data is clockwise cyclic when viewed from the outside of the polyhedron."));
	echo(str("The bevel angles are partial dihedral angles to the center of the polyhedron."));
	// Print sheet information for all requested faces.
	info_faces = is_undef(face_list) ? [0 : len(faces) - 1] : face_list;
	for (nf = info_faces)
	{
		face = faces[nf];
		face_points = [for (v = face) r / c_factor * vertices[v]];
		// Get face properties: edge lengths, vertex angles and edge bevels.
		edge_lengths = get_polygon_edge_lengths(face_points);
		vertex_angles = get_polygon_vertex_angles(face_points);
		edge_bevels = get_polygon_edge_bevels(vertices, faces, face);
		echo(str("face ", nf, " with ", len(face), " edges"));
		for (k = [0: len(face_points) - 1])
		{
			echo(str("l = ", round(10 * edge_lengths[k]) / 10, " mm; bevel = ", round(10 * edge_bevels[k]) / 10, "°; angle to next = ", round(10 * vertex_angles[k]) / 10, "°"));
		}
	}
}


////////////////////
// Implementation //
////////////////////


module draw_model_sheet(id, face_n, a = 1, n = 5, m = 2, r = 0, th = 1)
{
	// Get polyhedron data.
	vertices = polyhedron_vertices(id = id, n = n, m = m);
	faces = polyhedron_faces(id = id, n = n, m = m);
	c_factor = circumradius_factor(id = id, n = n, m = m);
	
	// Calculate the difference of a polyhedron of size [r] and size [r - th] and reduce to the requested face.
	difference()
	{
		draw_polyhedron(id = id, a = a, n = n, m = m, r = r);
		draw_polyhedron(id = id, a = a, n = n, m = m, r = r - th);
		reduce_to_face(r / c_factor * vertices, faces[face_n]);
	}	
}

// Reduce the polyhedron to a single face, everything from the center to the face is being kept.
module reduce_to_face(vertices, f, render_fac = 0)
{
	// Factor used to enlarge the pyramid for a proper cut_out.
	enlarge_factor = 6;
	// Create pyramid from face and polyhedron center.
	pyramid_points = concat([[0, 0, 0]], [for (v = f) vertices[v]]);
	// Substract that from a large enough centered cube to get a reduction shape.
	cube_size = sqrt(enlarge_factor) * norm(vertices[0]);
	difference()
	{		
		cube(cube_size, center = true);
		polyhedron(enlarge_factor * pyramid_points, pyramid_faces(len(f)));
	}
	// TODO: implement render_fac and RENDER_EPS for removing artefacts.
}

// Gives the faces for a pyramid, where the first vertex is the top and the remaining vertices form an n-gon base.
function pyramid_faces(n) = concat(
	[for (k = [1 : n]) [k % n + 1, k, 0]],
	[[for (k = [1 : n]) k]]
);


////////////////
// Properties //
////////////////

// Returns the edge lengths of a polygon (set of points).
function get_polygon_edge_lengths(points) = let(np = len(points)) [for (n = [0 : np - 1]) norm(points[n] - points[(n + 1) % np])];
	
// Returns the angles for each vertex of a polygon (set of points).
function get_polygon_vertex_angles(points) = let(np = len(points)) [for (n = [0 : np - 1]) angle_between_three_points(points[mod_plus(n - 1, np)], points[n], points[(n + 1) % np])];

// Returns the bevels for each of the edges of a polygon (set of points).
function get_polygon_edge_bevels(vertices, faces, f) = let(nv = len(f)) [for (n = [0 : nv - 1]) reduced_dihedral_angle(vertices, f, [f[n], f[(n + 1) % nv]])];


//////////////
// Geometry //
//////////////

function angle_between_three_points(p1, p2, p3) = let(x = p2 - p1, y = p2 - p3) acos(x * y / (norm(x) * norm(y)));

// Returns the reduced dihedral between the face (f) and the center of the polyhedron through the edge (e).
function reduced_dihedral_angle(vertices, f, e) = let
(
	n1 = face_normal(vertices, f),
	nc = normal_vector([0, 0, 0], vertices[e[0]], vertices[e[1]])
) acos(n1 * nc / (norm(n1) * norm(nc)));