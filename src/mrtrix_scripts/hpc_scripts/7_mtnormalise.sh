#!/bin/bash
#intensity normalization for each tissue compartment
#required even if biascorrect was already done
#script by Meaghan Perdue, April 2019

#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix
#for dissertation round of subjs this was run on gm_test.mif csf_test.mif and wmfod_test.mif because I had to rerun dwi2fod with the fixed masks, for new subjs, just run this as written based on outputs from 6_dwi2fod

cd /mrtrix_out/${1}
mtnormalise -mask dwi_preproc_upsampled_bet_mask.nii.gz wmfod.mif wmfod_norm.mif gm.mif gm_norm.mif csf.mif csf_norm.mif -debug -nthreads 4

#important - mtnormalise is sensitive to non-brain voxels in the mask, so use a conservative mask (from bet) for this step!
