#!/bin/bash
#prep T1 images and segment tissue types: CSF, GM, WM
#bet brain extraction - required to make sure FAST works properly
#FAST segment into 3 tissue types: 1=CSF, 2=GM, 3=WM
export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/
export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
#export bids=/Volumes/Research/A214/bids/

# cp $bids/sub-pa0981/ses-01/anat/sub-pa0981_ses-01_T1w.nii.gz $subject_masks
# fslswapdim $subject_masks/sub-pa0981_ses-01_T1w.nii.gz RL PA IS $subject_masks/sub-pa0981_ses-01_T1w_swapdim.nii.gz

# bet \
# 	$subject_masks/sub-pa0981_ses-01_T1w_swapdim.nii.gz \
# 	$subject_masks/sub-pa0981_bet.nii.gz \
# 	-g -.2

fast \
	-S 1 \
	-t 1 \
	-o $subject_masks/sub-pa0981 \
	-n 3 \
	$subject_masks/sub-pa0981_bet.nii.gz






