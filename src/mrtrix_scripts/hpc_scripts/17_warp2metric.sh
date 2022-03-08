#!/bin/bash
#calculate FC metric for each subject
#saves output to a single fixel directory for all subjects to accommodate later group FBA
#must run loop within container, do not run multiple subjects simultaneously 
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix


for i in $(cat subjlist.txt); do
	cd /mrtrix_out/${i}
	warp2metric subject2template_warp.mif -fc ../template/fixel_mask ../template/fc ${i}.mif -nthreads 4 -debug
	done
	