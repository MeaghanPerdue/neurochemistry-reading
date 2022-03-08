#!/bin/bash
#prep T1 images and segment tissue types: CSF, GM, WM
#bet brain extraction - required to make sure FAST works properly
#FAST segment into 3 tissue types: 1=CSF, 2=GM, 3=WM
export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/
export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks



bet \
		/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/sub-214065/ses-01/anat/sub-214065_ses-01_T1w.nii.gz \
		/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks/sub-214065_bet.nii.gz \
		-g -.2

fast \
		-S 1 \
		-t 1 \
		-o $subject_masks/sub-214065 \
		-n 3 \
		$subject_masks/sub-214065_bet.nii.gz






