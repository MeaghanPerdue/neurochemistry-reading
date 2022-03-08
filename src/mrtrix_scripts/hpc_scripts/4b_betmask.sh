#!/bin/bash
#convert upsampled image to .nii.gz for FSL compatibility
#create brainmask for FBA pipeline using FSL-bet


#export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

cd /mrtrix_out/${1}
mrconvert dwi_preproc_upsampled.mif dwi_preproc_upsampled.nii.gz
bet dwi_preproc_upsampled.nii.gz dwi_preproc_upsampled_bet.nii.gz -m

#check mask for holes
#conservative masks better for mtnormalise step