#!/bin/bash
#apply VOI mask to segmented T1w image
#create segmented images of each tissue type within mask
#calculate volumes of each tissue type and print to 
#this version is set to run on HPC via mrtrix container, submitting a seperate job per subject (looped script)
#but it runs fast so you could just run the loop within the script in a single job

# export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
# export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks

export subject_masks=/scratch/mvm16101/a214_data/derivatives/subject_masks

fslmaths \
	$subject_masks/${1}_seg.nii.gz \
	-mul $subject_masks/${1}_SMG.nii.gz \
	$subject_masks/${1}_SMG_seg.nii.gz

#calculate images for each tissue class
fslmaths \
	$subject_masks/${1}_SMG_seg.nii.gz \
	-thr 3 \
	$subject_masks/${1}_SMG_wm.nii.gz

fslmaths \
	$subject_masks/${1}_SMG_seg.nii.gz \
	-uthr 1 \
	$subject_masks/${1}_SMG_csf.nii.gz

fslmaths \
	$subject_masks/${1}_SMG_seg.nii.gz \
	-sub $subject_masks/${1}_SMG_wm.nii.gz \
	-sub $subject_masks/${1}_SMG_csf.nii.gz \
	$subject_masks/${1}_SMG_gm.nii.gz

# calculate VOI volume non-zero voxels (output= voxels volume)
SMG_VOL=`fslstats $subject_masks/${1}_SMG_seg.nii.gz -v`
echo ${1} $SMG_VOL >> $subject_masks SMG_VOL.txt	

SMG_CSF=`fslstats $subject_masks/${1}_SMG_csf.nii.gz -V`
SMG_GM=`fslstats $subject_masks/${1}_SMG_gm.nii.gz -V`
SMG_WM=`fslstats $subject_masks/${1}_SMG_wm.nii.gz -V`

echo ${1} $SMG_VOL $SMG_CSF $SMG_GM $SMG_WM >> $subject_masks/SMG_VOL_seg.txt
