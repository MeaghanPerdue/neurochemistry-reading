#!/bin/bash
#compute FDC metric for each subject
#saves output to a single fixel directory for all subjects to accommodate later group FBA
#must run loop within container, do not run multiple subjects simultaneously 
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

	
mkdir template/fdc
cp template/fc/index.mif template/fdc
cp template/fc/directions.mif template/fdc

for i in $(cat subjlist.txt); do
	mrcalc template/fd/${i}.mif template/fc/${i}.mif -mult template/fdc/${i}.mif -nthreads 4 -debug
	done
	