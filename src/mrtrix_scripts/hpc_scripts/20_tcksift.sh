#!/bin/bash
#run SIFT to reduce biases in whole brain tractogram
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

	
cd /mrtrix_out/template


tcksift tracks_20_million.tck wmfod_template.mif tracks_2_million_sift.tck -term_number 2000000 -nthreads 16 -debug