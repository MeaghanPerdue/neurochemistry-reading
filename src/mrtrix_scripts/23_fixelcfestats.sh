#!/bin/bash
#compute run stats on fd, fc and fdc 
#script by Meaghan Perdue, June 2021


cd /mrtrix_out/template

fixelcfestats fd_smooth/ files.txt design_matrix.txt contrast_matrix.txt matrix/ stats_fd/ -nthreads 4 -debug
fixelcfestats log_fc_smooth/ files.txt design_matrix.txt contrast_matrix.txt matrix/ stats_log_fc/ -nthreads 4 -debug
fixelcfestats fdc_smooth/ files.txt design_matrix.txt contrast_matrix.txt matrix/ stats_fdc/ -nthreads 4 -debug
