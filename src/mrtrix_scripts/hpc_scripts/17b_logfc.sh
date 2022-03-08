#!/bin/bash
#calculate log(FC) metric for each subject
#saves output to a single fixel directory for all subjects to accommodate later group FBA
#must run loop within container, do not run multiple subjects simultaneously 
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

cd /mrtrix_out
mkdir template/log_fc
cp template/fc/index.mif template/fc/directions.mif template/log_fc

for i in $(cat subjlist.txt); do
	mrcalc template/fc/${i}.mif -log template/log_fc/${i}.mif -nthreads 4 -debug
	done
	