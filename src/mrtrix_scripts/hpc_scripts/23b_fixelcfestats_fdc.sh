#!/bin/bash
#compute run stats on fdc
#script by Meaghan Perdue, June 2021


cd /mrtrix_out/template

fixelcfestats fdc_smooth/ files.txt design_matrix.txt contrast_matrix.txt matrix/ stats_fdc/ -nthreads 8 -debug
