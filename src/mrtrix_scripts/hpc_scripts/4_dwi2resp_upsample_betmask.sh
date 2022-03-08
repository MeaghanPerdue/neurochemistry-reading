#!/bin/bash
#optionally run biascorrect - this step is optional for better dwi2mask performance, but in our sample the masks came out worse after biascorrect, so skipping it
#dwi response estimation in mrtrix using dhollander method (for multi-shell, multi-tissue CSD)
#resample data
#create mask based on upsampled image using FSL BET (first converts .mif to .nii.gz to be readable by FSL)

#export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix


cd /mrtrix_out/${1}
#dwibiascorrect ants dwi_preprocessed.mif dwi_preproc_biascorr.mif -debug -force 

dwi2response dhollander -voxels voxels.mif dwi_preprocessed.mif wm_response.txt gm_response.txt csf_response.txt -debug -force
mrgrid dwi_preprocessed.mif regrid -vox 1.25 dwi_preproc_upsampled.mif -debug -force
#dwi2mask dwi_preproc_upsampled.mif dwi_mask_upsampled.mif -debug -force  #these masks left too much non-brain tissue, use bet mask script instead
mrconvert dwi_preproc_upsampled.mif dwi_preproc_upsampled.nii.gz
bet dwi_preproc_upsampled.nii.gz dwi_preproc_upsampled_bet.nii.gz -m


#check mask for holes
#conservative masks better for mtnormalise step