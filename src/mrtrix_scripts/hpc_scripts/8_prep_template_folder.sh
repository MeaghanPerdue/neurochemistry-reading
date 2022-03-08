#!/bin/bash
#generate study-specific unbiased FOD template (ok to do this with just 30-40 subjects)

#first, create template folder and link FOD images and masks into sub-folders in the template folder
export SCRATCH=/scratch/mvm16101
cd a214_data/derivatives/mrtrix

#mkdir -p template/fod_input
#mkdir template/mask_input

#symbolic link all FOD images and masks into their input folders
for i in $(cat $SCRATCH/subjlist.txt); do
	cp ${i}/wmfod_norm.mif template/fod_input/${i}.mif
	cp ${i}/dwi_preproc_upsampled_bet_mask.nii.gz template/mask_input/${i}.nii.gz
	done
	

