/* Tests: Topology 
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Tests for polyhedra library: topological properties.
*/

use <../polyhedra.scad>;


// General constants.
ERROR_MARGIN = 1e-14;


// Polyhedra to test.
//list = ["tetrahedron", "hexahedron", "tetrakis_hexahedron", "icosidodecahedron", "rhombicosidodecahedron"];
list = list_polyhedra();


// Display all polyhedra for visual checks.
for (poly = list)
{
	vertices = polyhedron_vertices(poly);
	edges = polyhedron_edges(poly);
	faces = polyhedron_faces(poly);
	echo(str("checking polyhedron: ", poly));
	echo(str("F = ", len(faces), " V = ", len(vertices), " E = ", len(edges)));
	
	// Check Euler characteristic.
	if (len(vertices) - len(edges) + len(faces) != 2)
		echo(str("WARNING: ", len(vertices), " (V) - ", len(edges), " (E) + ", len(faces), " (F) != 2"));
	
	// Check vertices connected to vertex.
	//c_vertices_to_v = [for (v = [0 : len(vertices) - 1]) len(vertices_connected_to_vertex(edges, faces, v))];
	//echo(c_vertices_to_v);
	
	// Check edges connected to vertex.
	//c_edges_to_v = [for (v = [0 : len(vertices) - 1]) len(edges_connected_to_vertex(edges, v))];
	//echo(c_edges_to_v);
	
	// Check edges connected to edge.
	//c_edges_to_e = [for (e = edges) len(edges_connected_to_edge(edges, e))];
	//echo(c_edges_to_e);
	
	// Check edges connected to face.
	//c_edges_to_f = [for (f = faces) len(edges_connected_to_face(edges, f))];
	//echo(c_edges_to_f);

	// Check faces connected to vertex.
	//c_faces_to_v = [for (v = [0 : len(vertices) - 1]) len(faces_connected_to_vertex(faces, v))];
	//echo(c_faces_to_v);
	
	// Check faces connected to edge.
	c_faces_to_e = [for (e = edges) faces_connected_to_edge(faces, e)];
	for (faces = c_faces_to_e)
		if (len(faces) != 2)
			echo(str("WARNING: number of faces not equal to 2 (but ", len(faces), ") somewhere in list", c_faces_to_e)); 

	// Check faces connected to face.
	//c_faces_to_f = [for (f = faces) len(faces_connected_to_face(edges, faces, f))];
	//echo(c_faces_to_f);
}
