#!/usr/bin/env python3
#
# performs the unit test for all polyhedra


############
# packages #
############

import subprocess
import re
import glob
import numpy
import os
import time


###################
# functions: misc #
###################


########
# main #
########

# create png images
rot_speed = (5, 10, 5)
max_cnt = 10
for rot_cnt in range(10):
	output_scad = subprocess.Popen(['openscad', '-o', 'test.svg', '--colorscheme', 'WhiteBkg', '--camera', '0, 0, 0, 0, 0, 0, 256', '--imgsize', '256,256', '--D', 'face_list=[0]', 'test_sheets.scad'], stdout = subprocess.PIPE, stderr = subprocess.STDOUT)
	
stdout = []
while True:
	line = output_scad.stdout.readline().decode("utf-8")
	stdout.append(line)
	if line == '' and output_scad.poll() != None:
		break
output_scad = ''.join(stdout)
time.sleep(1)	

