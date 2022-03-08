#!/bin/bash
#generate fixel-fixel connectivity matrix - requires ~32 GB RAM!
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

	
cd /mrtrix_out/template


fixelfilter fd smooth fd_smooth -matrix matrix/ -nthreads 16 -debug
fixelfilter log_fc smooth log_fc_smooth -matrix matrix/ -nthreads 16 -debug
fixelfilter fdc smooth fdc_smooth -matrix matrix/ -nthreads 16 -debug

