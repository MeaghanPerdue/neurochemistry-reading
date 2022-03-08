#!/bin/bash
#register each subject's FOD to study template
#warp all masks to template space
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix


cd /mrtrix_out/${1}
mrregister wmfod_norm.mif -mask1 dwi_preproc_upsampled_bet_mask.nii.gz template/wmfod_template.mif -nl_warp subject2template_warp.mif template2subject_warp.mif -nthreads 4 -debug
mrtransform dwi_preproc_upsampled_bet_mask.nii.gz -warp subject2template_warp.mif -interp nearest -datatype bit dwi_mask_in_template_space.mif -nthreads 4 -debug
