/* Iconhedra
 *
 * This script is part of the iconhedra tool. It is called by a Python
 * script to extract polyhedron geometry data from the openscad-polyhedra
 * library. It prints the points and faces to the console for parsing.
 *
 * @copyright 2025 Maikel de Vries
 * @license GPL-3.0
 */

include <../../polyhedra.scad>;

// The polyhedron to export. This is overridden from the command line.
polyhedron = "dodecahedron";

// Whether to echo a list of polyhedra.
echo_list = false;

if (echo_list)
{
    echo(str("<LIST>", list_polyhedra(), "<LIST>"));
}
else
{
    echo(str("<VERTICES>", polyhedron_vertices(polyhedron), "<VERTICES>")); 
    echo(str("<FACES>", polyhedron_faces(polyhedron), "<FACES>"));
}