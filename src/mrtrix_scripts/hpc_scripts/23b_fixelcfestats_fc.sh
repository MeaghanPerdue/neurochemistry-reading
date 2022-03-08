#!/bin/bash
#compute run stats on log_fc
#script by Meaghan Perdue, June 2021


cd /mrtrix_out/template

fixelcfestats log_fc_smooth/ files.txt design_matrix.txt contrast_matrix.txt matrix/ stats_log_fc/ -nthreads 8 -debug
