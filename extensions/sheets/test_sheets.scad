/* Polyhedral Sheets
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Extension for the polyhedra library: creates a polyhedron model out of sheets of material using certain types of edge connections.
*/


use <sheets.scad>;



// Settings.
poly = "dothedron";
poly_n = 5;
poly_m = 2;
model_radius = 180;
sheet_thickness = 1;
face_list = undef; //[6];
face_colors = [
"Gold", //0
"DarkBlue",
"DarkBlue",
"DarkGoldenrod",
"DarkGoldenrod", //4
"DodgerBlue",
"DarkBlue",
"DarkGoldenrod",
"DodgerBlue", //8
"DodgerBlue"];

draw_sheets_3d(id = poly, n = poly_n, m = poly_m, r = model_radius, th = sheet_thickness, face_list = face_list, face_colors = face_colors, debug = true);

//translate([-15, -10]) rotate([0, 0, 60]) draw_sheets_2d(id = poly, n = poly_n, m = poly_m, r = model_radius, th = sheet_thickness, face_list = face_list, debug = true);

//info_sheets(id = poly, n = poly_n, m = poly_m, r = model_radius, th = sheet_thickness, face_list = face_list);