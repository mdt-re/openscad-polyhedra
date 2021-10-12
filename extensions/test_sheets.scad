/* Polyhedral Sheets
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Extension for the polyhedra library: creates a polyhedron model out of sheets of material using certain types of edge connections.
*/


use <sheets.scad>;



// Settings.
poly = "twisted_prism";
poly_n = 5;
poly_m = 2;
model_radius = 64;
sheet_thickness = 9;
face_list = [2];


draw_sheets_3d(id = poly, n = poly_n, m = poly_m, r = model_radius, th = sheet_thickness, face_list = face_list, debug = true);

//translate([-40, 0]) draw_sheets_2d(id = poly, n = poly_n, m = poly_m, r = model_radius, th = sheet_thickness, face_list = face_list, debug = false);

info_sheets(id = poly, n = poly_n, m = poly_m, r = model_radius, th = sheet_thickness, face_list = face_list);