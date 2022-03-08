#!/bin/bash
#prep T1 images and segment tissue types: CSF, GM, WM
#bet brain extraction - required to make sure FAST works properly
#FAST segment into 3 tissue types: 1=CSF, 2=GM, 3=WM
#run via mrtrix container
# export bids=/scratch/mvm16101/a214_data
# export subject_masks=/scratch/mvm16101/a214_data/derivatives/subject_masks


for i in $(cat MRS_subs.txt); do
	bet \
		/bids_dir/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
		/bids_dir/derivatives/subject_masks/${i}_bet.nii.gz

	fast \
		-S 1 \
		-t 1 \
		-o /bids_dir/derivatives/subject_masks/${i} \
		-n 3 \
		/bids_dir/derivatives/subject_masks/${i}_bet.nii.gz
	done





