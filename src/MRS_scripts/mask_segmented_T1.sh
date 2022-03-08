#!/bin/bash
#apply VOI mask to segmented T1w image

export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks


fslmaths \
	$subject_masks/sub-pa0769_seg.nii.gz \
	-mul $subject_masks/sub-pa0769_SMG.nii.gz \
	$subject_masks/sub-pa0769_SMG_seg.nii.gz

#calculate images for each tissue class
fslmaths \
	$subject_masks/sub-pa0769_SMG_seg.nii.gz \
	-thr 3 \
	$subject_masks/sub-pa0769_SMG_wm.nii.gz

fslmaths \
	$subject_masks/sub-pa0769_SMG_seg.nii.gz \
	-uthr 1 \
	$subject_masks/sub-pa0769_SMG_csf.nii.gz

fslmaths \
	$subject_masks/sub-pa0769_SMG_seg.nii.gz \
	-sub $subject_masks/sub-pa0769_SMG_wm.nii.gz \
	-sub $subject_masks/sub-pa0769_SMG_csf.nii.gz \
	$subject_masks/sub-pa0769_SMG_gm.nii.gz




# calculate VOI volume non-zero voxels (output= voxels volume)
SMG_VOL=`fslstats $subject_masks/sub-pa0769_SMG_seg.nii.gz -v`
# echo sub-pa0769 $SMG_VOL >> $subject_masks SMG_VOL.txt	

SMG_CSF=`fslstats $subject_masks/sub-pa0769_SMG_csf.nii.gz -V`
SMG_GM=`fslstats $subject_masks/sub-pa0769_SMG_gm.nii.gz -V`
SMG_WM=`fslstats $subject_masks/sub-pa0769_SMG_wm.nii.gz -V`

echo sub-pa0769 $SMG_VOL $SMG_CSF $SMG_GM $SMG_WM >> $subject_masks/SMG_VOL_seg.txt