#!/usr/bin/env python3
#
"""
Generates a vector graphic (SVG) icon for a given polyhedron.

This script extracts the 3D geometry from the openscad-polyhedra library,
projects it onto a 2D plane from a random viewpoint, calculates shading
based on a light source, and generates a clean SVG file.

Usage:
    ./iconhedra.py <polyhedron_name> [--color '#3498db'] [--animation DURATION]

Example:
    ./iconhedra.py icosahedron --animation 10
    
@copyright 2025 Maikel de Vries
@license GPL-3.0
"""

import argparse
import json
import random
import re
import subprocess
import sys
import math

try:
    import numpy as np
    import svgwrite
except ImportError:
    print("Required packages not found. Please run:", file=sys.stderr)
    print("pip install numpy svgwrite", file=sys.stderr)
    sys.exit(1)


def get_polyhedron_data(polyhedron_name=None, scad_file=None):
    """Calls OpenSCAD to get the points and faces for a polyhedron."""
    if scad_file:
        command = ['openscad', '-o', 'dummy.stl', scad_file]
    elif polyhedron_name:
        command = ['openscad', '-o', 'dummy.stl', '--D', f'polyhedron="{polyhedron_name}"', 'iconhedra.scad']
    else:
        raise ValueError("Either polyhedron_name or scad_file must be provided.")
    output_scad = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    text_vertices = re.search(r'<VERTICES>[\d\s\.e,\-\[\]]*<VERTICES>', output_scad.stdout.decode("utf-8"))
    text_faces = re.search(r'<FACES>[\d\s,\[\]]*<FACES>', output_scad.stdout.decode("utf-8"))
    vertices = re.findall(r'\[[\d\se\.,\-]*\]', text_vertices.group(0).replace('<VERTICES>', ''))
    faces = re.findall(r'\[[\d\s,]*\]', text_faces.group(0).replace('<FACES>', ''))
    vertices = [np.array([float(f) for f in v.strip('[]').split(',')]) for v in vertices]
    faces = [np.array([int(f) for f in v.strip('[]').split(',')]) for v in faces]

    # Convert list of arrays to a single NumPy array
    return np.array(vertices), faces

def get_polyhedron_list():
    """Calls OpenSCAD to get the a list of all available polyhedra."""
    openscad_file = 'iconhedra.scad'
    output_scad = subprocess.run(['openscad', '-o', 'dummy.stl', '--D', f'echo_list=true', openscad_file], stdout = subprocess.PIPE, stderr = subprocess.STDOUT)

    text_polyhedra = re.search(r'<LIST>[\w\s,"_\[\]]*<LIST>', output_scad.stdout.decode("utf-8"))
    polyhedra = re.findall(r'[\w]+', text_polyhedra.group(0).replace('<LIST>', ''))
    return polyhedra

def get_rotation_matrix(rx, ry, rz):
    """Creates a 3D rotation matrix."""
    rx, ry, rz = map(math.radians, [rx, ry, rz])
    Rx = np.array([[1, 0, 0], [0, math.cos(rx), -math.sin(rx)], [0, math.sin(rx), math.cos(rx)]])
    Ry = np.array([[math.cos(ry), 0, math.sin(ry)], [0, 1, 0], [-math.sin(ry), 0, math.cos(ry)]])
    Rz = np.array([[math.cos(rz), -math.sin(rz), 0], [math.sin(rz), math.cos(rz), 0], [0, 0, 1]])
    return Rz @ Ry @ Rx

def get_rotation_matrix_around_axis(axis, angle_deg):
    """Creates a 3D rotation matrix for rotation around a given axis by a given angle."""
    angle_rad = math.radians(angle_deg)
    axis = np.asarray(axis)
    axis = axis / np.linalg.norm(axis)  # Normalize axis

    # Using quaternion to rotation matrix conversion for simplicity and stability
    a = math.cos(angle_rad / 2.0)
    b, c, d = -axis * math.sin(angle_rad / 2.0)
    
    aa, bb, cc, dd = a*a, b*b, c*c, d*d
    bc, ad, ac, ab, bd, cd = b*c, a*d, a*c, a*b, b*d, c*d
    
    return np.array([[aa+bb-cc-dd, 2*(bc-ad), 2*(bd+ac)],
                     [2*(bc+ad), aa+cc-bb-dd, 2*(cd-ab)],
                     [2*(bd-ac), 2*(cd+ab), aa+dd-bb-cc]])


def hex_to_rgb(hex_color):
    """Converts a hex color string to an (r, g, b) tuple."""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))


def generate_icon(output_file, base_color_hex, polyhedron_name=None, scad_file=None, animation_duration=None, orientation=None, rotation_axis=None):
    """
    Generates a shaded SVG icon for the specified polyhedron.

    Args:
        polyhedron_name (str): Name of the polyhedron.
        output_file (str): Path for the output SVG.
        base_color_hex (str): Base color for faces in hex format (e.g., '#3498db').
        scad_file (str or None): Path to an OpenSCAD file that echos vertices and faces.
        animation_duration (float or None): Duration in seconds for a 360-degree rotation animation.
        orientation (list or None): A list of three floats for [rx, ry, rz] rotation in degrees.
        rotation_axis (list or None): A vector [x, y, z] to rotate around for animations.
    """
    # --- 1. Get 3D data ---
    points_3d, faces = get_polyhedron_data(polyhedron_name=polyhedron_name, scad_file=scad_file)
    if points_3d.size == 0:
        print(f"Could not retrieve data for '{polyhedron_name or scad_file}'.", file=sys.stderr)
        return

    # --- 2. Set up scene ---
    view_vector = np.array([0, 0, 1]) # Look along Z axis
    light_source = np.array([1.0, 2.0, 3.0]) # Use floats to prevent casting errors
    light_source /= np.linalg.norm(light_source) # Normalize
    base_color_rgb = hex_to_rgb(base_color_hex)

    # --- 3. Process faces for each frame ---
    num_frames = 72  # Number of keyframes for the animation
    if orientation:
        rx, ry, rz = orientation
        initial_rotation = get_rotation_matrix(rx, ry, rz)
    else:
        initial_rotation = get_rotation_matrix(random.uniform(0, 360), random.uniform(0, 360), random.uniform(0, 360))
    
    # A list for each face, to hold its animation values (points, color)
    face_animations = [ {"points_values": [], "color_values": [], "visibility_values": []} for _ in faces ]

    all_frames_rotated_points = [] # To calculate bounds for the entire animation

    print("Generating animation frames...")
    for frame in range(num_frames):
        angle = (360 / num_frames) * frame
        # Animate rotation around the Y-axis, preserving the initial random tilt
        anim_rot_matrix = get_rotation_matrix_around_axis(rotation_axis or [0, 1, 0], angle)
        rot_matrix = anim_rot_matrix @ initial_rotation if animation_duration else initial_rotation
        rotated_points = points_3d @ rot_matrix

        # Process all faces for this frame
        frame_faces = []
        for i, face_indices in enumerate(faces):
            face_points = rotated_points[face_indices]
            v1, v2 = face_points[1] - face_points[0], face_points[2] - face_points[0]
            normal = np.cross(v1, v2)
            norm = np.linalg.norm(normal)
            if norm == 0: continue
            normal /= norm

            # Back-face culling
            is_visible = np.dot(normal, view_vector) >= 0

            # Lighting
            ambient = 0.3
            diffuse = max(0, np.dot(normal, light_source))
            shade = ambient + (1 - ambient) * diffuse
            color = tuple(int(c * shade) for c in base_color_rgb)
            color_hex = f"rgb({color[0]},{color[1]},{color[2]})"

            # Orthographic projection
            points_2d = [p[:2] for p in face_points]
            avg_depth = np.mean(face_points[:, 2])

            frame_faces.append({
                "face_index": i,
                "points": points_2d,
                "depth": avg_depth,
                "color": color_hex,
                "visible": is_visible
            })
        
        if animation_duration:
            all_frames_rotated_points.append(rotated_points)

        # Sort faces from back to front for this frame
        frame_faces.sort(key=lambda f: f['depth'])

        # Store animation values
        for face_data in frame_faces:
            idx = face_data["face_index"]
            points_str = " ".join([f"{p[0]:.4f},{p[1]:.4f}" for p in face_data["points"]])
            face_animations[idx]["points_values"].append(points_str)
            face_animations[idx]["color_values"].append(face_data["color"])
            face_animations[idx]["visibility_values"].append("visible" if face_data["visible"] else "hidden")

        # For static image generation, only process the first frame
        if animation_duration is None and frame == 0:
            faces_to_draw = [f for f in frame_faces if f['visible']]
            break

    # --- 4. Generate SVG ---
    # Set up SVG canvas
    size = 512
    dwg = svgwrite.Drawing(output_file, profile='tiny', size=(f'{size}px', f'{size}px'))
    
    # Normalize coordinates to fit in the viewbox
    # For animations, use points from all frames to get a stable bounding box.
    # For static images, use only the initial rotation.
    all_rotated_points = np.concatenate(all_frames_rotated_points) if animation_duration else (points_3d @ initial_rotation)

    all_2d_points = all_rotated_points[:, :2]
    min_coord = all_2d_points.min()
    max_coord = all_2d_points.max()
    scale = 0.9 * size / (max_coord - min_coord)
    
    # Center the drawing
    offset_x = -min_coord * scale + (size - (max_coord - min_coord) * scale) / 2
    offset_y = -min_coord * scale + (size - (max_coord - min_coord) * scale) / 2
    
    def scale_points_from_str(points_str):
        """Scales points from a string and returns a list of tuples."""
        points = [tuple(map(float, p.split(','))) for p in points_str.split(' ')]
        return [(p[0] * scale + offset_x, p[1] * scale + offset_y) for p in points]

    def format_points_to_str(points_list):
        """Formats a list of point tuples into an SVG-ready string."""
        return " ".join([f"{p[0]:.4f},{p[1]:.4f}" for p in points_list])

    if animation_duration is None:
        # --- Static Image Generation ---
        for face in faces_to_draw:
            scaled_points = [(p[0] * scale + offset_x, p[1] * scale + offset_y) for p in face['points']]
            dwg.add(dwg.polygon(scaled_points, fill=face['color']))
    else:
        # --- Animated Image Generation ---
        # Create a group for each face that will be animated
        # We draw them in the original face order, relying on the z-buffer (Painter's algorithm)
        # of the SVG renderer to handle overlaps correctly during animation.
        for anim_data in face_animations:
            # Skip faces that were never visible
            if not anim_data["points_values"]:
                continue

            scaled_points_list = [scale_points_from_str(ps) for ps in anim_data["points_values"]]
            points_values_str = ";".join(map(format_points_to_str, scaled_points_list))
            color_values_str = ";".join(anim_data["color_values"])
            visibility_values_str = ";".join(anim_data["visibility_values"])
            
            initial_points = scaled_points_list[0]
            initial_color = anim_data["color_values"][0]
            initial_visibility = anim_data["visibility_values"][0]

            poly = dwg.polygon(initial_points, fill=initial_color, visibility=initial_visibility)
            
            poly.add(svgwrite.animate.Animate(
                "points", dur=f"{animation_duration}s", values=points_values_str, repeatCount="indefinite"
            ))
            poly.add(svgwrite.animate.Animate(
                "fill", dur=f"{animation_duration}s", values=color_values_str, repeatCount="indefinite"
            ))
            poly.add(svgwrite.animate.Animate(
                "visibility", dur=f"{animation_duration}s", values=visibility_values_str, repeatCount="indefinite", calcMode="discrete"
            ))
            
            dwg.add(poly)

    dwg.save()
    print(f"Successfully generated icon: {output_file}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate a polyhedron SVG icon from 3D data.")
    parser.add_argument("polyhedron", nargs='?', default=None, help="Name of the polyhedron from the library (e.g., 'dodecahedron').")
    parser.add_argument("-l", "--list", action="store_true", help="List all available polyhedra and exit.")
    parser.add_argument("-f", "--file", help="Path to an OpenSCAD file that echos vertices and faces for a single polyhedron.")
    parser.add_argument("-a", "--animation", type=float,
                        help="Generate an animated SVG rotating 360 degrees over the specified duration in seconds (e.g., 10).")
    parser.add_argument("-c", "--color", default="#3498db", help="Base color in hex format (e.g., '#3498db').")
    parser.add_argument("-o", "--orientation", help="Set initial orientation as comma-separated degrees for x,y,z rotation "
                                              "(e.g., '20,0,0'). Defaults to a random tilt.")
    parser.add_argument("-r", "--rotation-axis", help="Set animation rotation axis as a comma-separated vector (e.g., '1,1,0'). "
                                                "Defaults to '0,1,0' (Y-axis).")
    args = parser.parse_args()

    if args.file and args.polyhedron:
        print("Error: --file and polyhedron name are mutually exclusive.", file=sys.stderr)
        sys.exit(1)

    if args.list:
        polyhedra_list = get_polyhedron_list()
        if polyhedra_list:
            print("Available polyhedra:")
            for name in sorted(polyhedra_list):
                print(f"  - {name}")
    elif args.polyhedron or args.file:
        orientation_angles = None
        rotation_axis_vector = None
        if args.orientation:
            try:
                orientation_angles = [float(angle) for angle in args.orientation.split(',')]
                if len(orientation_angles) != 3:
                    raise ValueError("Orientation must have exactly three values.")
            except (ValueError, TypeError):
                print("Error: --orientation must be three comma-separated numbers (e.g., '20,0,0').", file=sys.stderr)
                sys.exit(1)

        if args.rotation_axis:
            try:
                rotation_axis_vector = [float(v) for v in args.rotation_axis.split(',')]
                if len(rotation_axis_vector) != 3:
                    raise ValueError("Rotation axis must have exactly three values.")
            except (ValueError, TypeError):
                print("Error: --rotation-axis must be three comma-separated numbers (e.g., '1,1,0').", file=sys.stderr)
                sys.exit(1)

        if args.file:
            import os
            base_name = os.path.splitext(os.path.basename(args.file))[0]
            name_part = base_name
        else:
            name_part = args.polyhedron

        if args.animation:
            output_filename = f"anim_{name_part}.svg"
        else:
            output_filename = f"icon_{name_part}.svg"
        generate_icon(output_filename, args.color, polyhedron_name=args.polyhedron, scad_file=args.file, animation_duration=args.animation, orientation=orientation_angles, rotation_axis=rotation_axis_vector)
    else:
        parser.print_help()
        sys.exit(1)
