#!/bin/bash
#run mrtrix bias correction
#resample data
#create mask based on upsampled image


export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

for subj in $(cat subjlist.txt); do
	cd $mrtrix_out/$subj
	dwibiascorrect -ants dwi_preprocessed.mif dwi_preproc_biascorr.mif
	mrresize -voxel 1.25 dwi_preproc_biascorr.mif dwi_preproc_biascorr_upsampled.mif
	dwi2mask dwi_preproc_biascorr_upsampled.mif dwi_mask_upsampled.mif
	done

#check mask for holes
