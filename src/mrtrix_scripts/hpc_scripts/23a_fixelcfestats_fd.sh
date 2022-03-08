#!/bin/bash
#compute run stats on fd 
#script by Meaghan Perdue, June 2021


cd /mrtrix_out/template

fixelcfestats fd_smooth/ files.txt design_matrix.txt contrast_matrix.txt matrix/ stats_fd/ -nthreads 8 -debug
