/* Polyhedral Dice
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * Example for the polyhedra library: a variety of dice can easily be designed.
*/

// TODO: Consistent rotation of image on each of the faces.
// TODO: Round the edges and vertex corners.
// TODO: Draw something on the edge instead of text.


use <../polyhedra.scad>;


//////////////////
// Dice Drawing //
//////////////////

// Creates a dice with the following options:
//  - poly: the polyhedron to use.
//  - symbols: a list of text symbols to display.
//  - a: the polyhedron edge size.
//  - r:  the polyhedron circumradius (overwrites a if non-zero).
//  - inset: the depth of the text engraving.
//  - font: used for the symbols.
module dice(poly = "hexahedron", symbols = [], a = 32, r = 0, inset = 1, font = "Noto Sans Symbols:style=Regular")
{
	size = r == 0 ? a : r / circumradius_factor(poly);
	// Get faces: center, orientation and polygon inradius.
	faces_center = polyhedron_faces_center(poly);
	faces_orientation = polyhedron_faces_orientation(poly);
	faces_inradius = polyhedron_faces_inradius(poly);
	// Create default symbols 1, 2, ... if needed.
	symbols = symbols != [] ? symbols : [for (i = [1 : len(faces_center)]) str(i)];
	difference()
	{
		// Draw the polyhedron.
		draw_polyhedron(poly, a = size);
		
		// Loop over all faces.
		for (i = [0 : len(faces_center) - 1])
		{
			font_size = sqrt(6) / 2 * size * faces_inradius[i];
			translate(size * faces_center[i])
				rotate(faces_orientation[i][0], faces_orientation[i][1])
					linear_extrude(inset, center = true)
						text(
							symbols[i % len(symbols)],
							halign = "center",
							valign = "center",
							size = font_size,
							font = font,
							$fn = 100
						);
		}
	}
}


///////////////////
// Dice Examples //
///////////////////

// Uncomment one of the dice to render it. In general dice with equal probability are to land on each of its faces are created from Platonic and Catalan solids where all faces are equal.
// See also: https://en.wikipedia.org/wiki/Dice#Rarer_variations
// Order by number of faces these are:
//  - faces:  4 | tetrahedron
//  - faces:  6 | hexahedron
//  - faces:  8 | octahedron
//  - faces: 12 | dodecahedron, triakis_tetrahedron, rhombic_dodecahedron
//  - faces: 20 | icosahedron
//  - faces: 24 | tetrakis_hexahedron
//  - faces: 30 | rhombic_triacontahedron

// Standard dice.
dice(r = 32);

// Dice with twelve constellations.
//dice(poly = "rhombic_dodecahedron", symbols = ["\u2648","\u2649","\u264A","\u264B","\u264C","\u264D","\u264E","\u264F","\u2650","\u2651","\u2652","\u2653"], r = 32);

// Dice for selecting a random chess piece.
//dice(poly = "dodecahedron", symbols = ["♔","♕","♖","♗","♘","♙","♚","♛","♜","♝","♞","♟"], font = "FreeSerif", r = 32);

// Dice for card game suits.
//dice(poly = "tetrahedron", symbols = ["♠", "♣", "♥", "♦"], font = "FreeSerif", r = 32);

// Dice for the eight planets (pluto is gone after all!).
//dice(poly = "octahedron", symbols = ["\u263F","\u2640","\u2641","\u2642","\u2643","\u2644","\u2645","\u2646"], r = 32);

// Dice with 30 numbers.
//dice(poly = "rhombic_triacontahedron", r = 32);