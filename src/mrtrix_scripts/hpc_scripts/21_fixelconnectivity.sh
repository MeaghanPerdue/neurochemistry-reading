#!/bin/bash
#generate fixel-fixel connectivity matrix - requires ~32 GB RAM!
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

	
cd /mrtrix_out/template

fixelconnectivity fixel_mask/ tracks_2_million_sift.tck matrix/ -nthreads 16 -debug 
