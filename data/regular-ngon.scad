/* Polyhedra Library Data: Regular N-gon
 *
 * @copyright Maikel de Vries, 2020
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html
*/


// Source: https://en.wikipedia.org/wiki/Prism_(geometry)
function VERTICES_PRISM(n = 5) = 
	let (
		r = 1 / (2 * sin(180 / n))
	)
	[for (k = [0 : 2 * n - 1]) [r * cos(360 * floor(k / 2) / n), r * sin(360 * floor(k / 2) / n), pow(-1, k) * 1 / 2]];
function FACES_PRISM(n = 5) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces = [for (k = [0 : n - 1]) [for (l = [1, 0, 2, 3]) (l + 2 * k) % (2 * n)]]
	) 
	concat([top_face, bottom_face], side_faces);
function CIRCUMRADIUS_PRISM(n = 5) = 1 / sin(atan(sin(180 / n))) / 2;

// Source: https://en.wikipedia.org/wiki/Antiprism
function VERTICES_ANTIPRISM(n = 5) =
	let (
		r = 1 / (2 * sin(180 / n)),
		h = sqrt((cos(180 / n) - cos(360 / n)) / 2)
	)
	[for (k = [0 : 2 * n - 1]) [r * cos(180 * k / n), r * sin(180 * k / n), r * pow(-1, k) * h]];
function FACES_ANTIPRISM(n = 5) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces_top = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [2 : -1 : 0]) (l + k) % (2 * n)]],
		side_faces_bottom = [for (k = [1 : 2 : 2 * n - 1]) [for (l = [0 : 2]) (l + k) % (2 * n)]]	
	)
	concat([top_face, bottom_face], side_faces_top, side_faces_bottom);
function CIRCUMRADIUS_ANTIPRISM(n = 5) = 1 / 4 * sqrt(4 + 1 / pow(sin(90 / n), 2));
		
// Source: https://en.wikipedia.org/wiki/Prism_(geometry)#Twisted_prism
function VERTICES_TWISTED_PRISM(n = 5) =
	let (
		r = 1 / (2 * sin(180 / n)),
		h = sqrt((cos(180 / n) - cos(360 / n)) / 2)
	)
	[for (k = [0 : 2 * n - 1]) [r * cos(180 * k / n), r * sin(180 * k / n), r * pow(-1, k) * h]];	
function FACES_TWISTED_PRISM_LAEVO(n = 5) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces_top = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [4, 1, 2]) (l + k) % (2 * n)]],
		side_faces_bottom = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [4, 3, 1]) (l + k) % (2 * n)]]	
	)
	concat([top_face, bottom_face], side_faces_top, side_faces_bottom);
function FACES_TWISTED_PRISM_DEXTRO(n = 5) = 
	let (
		top_face = [for (k = [0 : n - 1]) 2 * k + 1],
		bottom_face = [for (k = [0 : n - 1]) 2 * (n - k - 1)],
		side_faces_top = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [2, 3, 0]) (l + k) % (2 * n)]],
		side_faces_bottom = [for (k = [0 : 2 : 2 * n - 2]) [for (l = [0, 3, 1]) (l + k) % (2 * n)]]	
	)
	concat([top_face, bottom_face], side_faces_top, side_faces_bottom);
function CIRCUMRADIUS_TWISTED_PRISM(n = 5) = 1 / 4 * sqrt(4 + 1 / pow(sin(90 / n), 2));

// Source: https://en.wikipedia.org/wiki/Trapezohedron
function VERTICES_TRAPEZOHEDRON(n = 5) =
	let (
		r = 1 / (2 * sin(180 / n)),
		o = 1 / 4,
		h = 1
	)
	concat([[0, 0, h], [0, 0, -h]], [for (k = [0 : 2 * n - 1]) [r * cos(180 * k / n), r * sin(180 * k / n), pow(-1, k) * o]]);
function FACES_TRAPEZOHEDRON(n = 5) = 
	let (
		c = 2 * n,
		top_faces = [for (k = [0 : n - 1]) [0, (2 + 2*k) % c + 2, 3 + 2*k, 2 + 2*k]],
		bottom_faces = [for (k = [0 : n - 1]) [1, 3 + 2*k, (2 + 2*k) % c + 2, (3 + 2*k) % c + 2]]
	)
	concat(top_faces, bottom_faces);
function CIRCUMRADIUS_TRAPEZOHEDRON(n = 5) = 1 / sin(atan(sin(180 / n))) / 2;
		
// Source: https://en.wikipedia.org/wiki/Prism_(geometry)#Star_prism
function VERTICES_STAR_PRISM(n = 5, m = 2) = 
	let (
		r = 1 / (2 * sin(180 / n)),
		vertices_top = [for (k = [0 : n - 1]) [r * cos(360 * k / n), r * sin(360 * k / n), 1 / 2]],
		vertices_bottom = [for (k = [0 : n - 1]) [r * cos(360 * k / n), r * sin(360 * k / n), -1 / 2]],
		vertices_star_top = [for (k = [0 : n - 1]) line_intersection(vertices_top[k], vertices_top[(k + m) % n], vertices_top[(k + 1) % n], vertices_top[mod_plus(k - m + 1, n)])],
		vertices_star_bottom = [for (k = [0 : n - 1]) line_intersection(vertices_bottom[k], vertices_bottom[(k + m) % n], vertices_bottom[(k + 1) % n], vertices_bottom[mod_plus(k - m + 1, n)])]
	)
	concat(vertices_top, vertices_bottom, vertices_star_top, vertices_star_bottom);
function FACES_STAR_PRISM(n = 5, m = 2) = 
	let (
		top_face = [for (k = [2 * n - 1 : - 1 : 0]) floor(k / 2) + 2 * n * (k % 2)],
		bottom_face = [for (k = [0 : 2 * n - 1]) n + floor(k / 2) + 2 * n * (k % 2)],
		side_faces = concat(
			[for (k = [0 : n - 1]) [for (l = [0, 2*n, 3*n, n]) (l + k)]],
			[for (k = [0 : n - 1]) [for (l = [0, n, 3*n-1+n*(1-ceil(k/n)), 2*n-1+n*(1-ceil(k/n))]) (l + k)]]	
		)
	) 
	concat([top_face, bottom_face], side_faces);
function CIRCUMRADIUS_STAR_PRISM(n = 5, m = 2) = 1 / sin(atan(sin(180 / n))) / 2;
		
// Source: https://en.wikipedia.org/wiki/Bipyramid#Star_bipyramids
function VERTICES_STAR_DIPYRAMID(n = 5, m = 2) =
	let (
		r = 1 / cos(180 / n),
		h = 1,
		vertices_poles = [[0, 0, h], [0, 0, -h]],
		vertices_ngon = [for (k = [0 : n - 1]) [r * cos(360 * k / n), r * sin(360 * k / n), 0]],
		vertices_star = [for (k = [0 : n - 1]) line_intersection(vertices_ngon[k], vertices_ngon[(k + m) % n], vertices_ngon[(k + 1) % n], vertices_ngon[mod_plus(k - m + 1, n)])]
	)
	concat(vertices_poles, vertices_ngon, vertices_star);
function FACES_STAR_DIPYRAMID(n = 5, m = 2) = 
	let (
		faces_top_forward = [for (k = [0 : n - 1]) [0, 2 + k, (n + 2) + (n + k - 1) % n]],
		faces_top_backward = [for (k = [0 : n - 1]) [0, (n + 2) + (n + k) % n, 2 + k]],
		faces_bottom_forward = [for (k = [0 : n - 1]) [1, (n + 2) + (n + k - 1) % n, 2 + k]],
		faces_bottom_backward = [for (k = [0 : n - 1]) [1, 2 + k, (n + 2) + (n + k) % n]]
	)
	concat(faces_top_forward, faces_top_backward, faces_bottom_forward, faces_bottom_backward);
function CIRCUMRADIUS_STAR_DIPYRAMID(n = 5, m = 2) = 1 / cos(180 / n);
