/* Sheet Model
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Example for the polyhedra library: create a polyhedron model out of sheets of material.
*/


use <../polyhedra.scad>;


///////////////
// Constants //
///////////////

RENDER_EPS = 0.001;


// Settings.
poly = "small_stellated_dodecahedron";
model_radius = 80;
sheet_thickness = 6;
render_2d = true;


// Get model data.
vertices = polyhedron_vertices(id = poly);
edges = polyhedron_edges(id = poly);
faces = polyhedron_faces(id = poly);
c_factor = circumradius_factor(id = poly);


// Display model sheets.
if (!render_2d)
	for (n = [0: len(faces) - 1])
	{
		// Add a slight gap between each face for visualization purposes.
		face_center = model_radius / c_factor * polyhedron_faces_center(id = poly)[n];
		translate(10 * face_center / model_radius)
			draw_model_sheet(id = poly, face_n = n, r = model_radius, th = sheet_thickness);

	}
if (!render_2d)
	number_faces(id = poly, r = model_radius + 10);

// Print model and construction data.
echo(str("Construction data for ", poly, " with ", len(faces), " faces:"));
for (n = [0 : 0]) //len(faces) - 1])
{
	face = faces[n];
	face_points = [for (v = face) model_radius / c_factor * vertices[v]];
	// Get face properties: edge lengths, vertex angles and edge bevels.
	edge_lengths = get_polygon_edge_lengths(face_points);
	vertex_angles = get_polygon_vertex_angles(face_points);
	edge_bevels = get_polygon_edge_bevels(vertices, faces, face);
	echo(str("face ", n, " with ", len(face), " edges"));
	for (k = [0: len(face_points) - 1])
	{
		echo(str("l = ", round(10 * edge_lengths[k]) / 10, " mm; bevel = ", round(10 * edge_bevels[k]) / 10, "°; angle to next = ", round(10 * vertex_angles[k]) / 10, "°"));
	}
}

echo(str("All face data is clockwise cyclic when viewed from the outside of the polyhedron."));
echo(str("The bevel angles are partial dihedral angles to the center of the polyhedron."));


// Draw 2D sheets for printing and construction aid.
if (render_2d)
	for (n = [0 : 0]) //[0 : len(faces) - 1])
	{
		face_center = model_radius / c_factor * polyhedron_faces_center(id = poly)[n];
		face_normal = normal_vector(vertices[faces[n][0]], vertices[faces[n][1]], vertices[faces[n][2]]);
		normal_xy = [0, 0, 1];
		rot = acos(-face_normal * normal_xy / norm(-face_normal));
		axis = cross(-face_normal, normal_xy);
		x = n % floor(sqrt(len(faces)));
		y = floor(n / floor(sqrt(len(faces))));
		projection(cut = true)
			translate([2 * model_radius * x, 2 * model_radius * y, RENDER_EPS])
				rotate(rot, axis)
					translate(-face_center)
						draw_model_sheet(id = poly, face_n = n, r = model_radius, th = sheet_thickness);
	}
// TODO: Add numbering and bevel angles to the 2D sheets for easier processing.



///////////////
// Functions //
///////////////

module draw_model_sheet(id, face_n, a = 1, n = 5, m = 2, r = 0, th = 1)
{
	faces = polyhedron_faces(id = poly);
	c_factor = circumradius_factor(id = poly);
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
	
// Several polygon properties: edge lengths, vertex angles and edge bevels.
function get_polygon_edge_lengths(points) = let(np = len(points)) [for (n = [0 : np - 1]) norm(points[n] - points[(n + 1) % np])];
	
function get_polygon_vertex_angles(points) = let(np = len(points)) [for (n = [0 : np - 1]) angle_between_three_points(points[mod_plus(n - 1, np)], points[n], points[(n + 1) % np])];
	
function get_polygon_edge_bevels(vertices, faces, f) = let(nv = len(f)) [for (n = [0 : nv - 1]) reduced_dihedral_angle(vertices, f, [f[n], f[(n + 1) % nv]])];

function angle_between_three_points(p1, p2, p3) = let(x = p2 - p1, y = p2 - p3) acos(x * y / (norm(x) * norm(y)));

// Returns the reduced dihedral between the face (f) and the center of the polyhedron through the edge (e).
function reduced_dihedral_angle(vertices, f, e) = let
(
	n1 = face_normal(vertices, f),
	nc = normal_vector([0, 0, 0], vertices[e[0]], vertices[e[1]])
) acos(n1 * nc / (norm(n1) * norm(nc)));