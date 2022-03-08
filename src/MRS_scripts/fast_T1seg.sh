#!/bin/bash
#prep T1 images and segment tissue types: CSF, GM, WM
#bet brain extraction - required to make sure FAST works properly
#FAST segment into 3 tissue types: 1=CSF, 2=GM, 3=WM
export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks


for i in $(cat MRS_subs.txt); do
	bet \
		$bids/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
		$subject_masks/${i}_bet.nii.gz

	fast \
		-S 1 \
		-t 1 \
		-o $subject_masks/${i} \
		-n 3 \
		$subject_masks/${i}_bet.nii.gz
	done





