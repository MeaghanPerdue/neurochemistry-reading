#!/bin/bash
#register subjects' T1w images to their preprocessed DWI images; rigid transformation
#script by Meaghan Perdue, May 2021
#for subjects with multiple T1 runs, need to edit script to specify which run to use

# mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix
# bids_data=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data

cd /mrtrix_out/${1}
mrregister -type rigid -mask2 dwi_mask_upsampled.mif -transformed T1w_transformed.mif $bids_data/${1}/ses-01/anat/$subj_ses-01_T1w.nii.gz dwi_preproc_biascorr_upsampled.mif
	