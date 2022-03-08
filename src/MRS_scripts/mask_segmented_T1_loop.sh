#!/bin/bash
#apply VOI mask to segmented T1w image
#create segmented images of each tissue type within mask
#calculate volumes of each tissue type and print to txt files


export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks

for i in $(cat subjlist.txt); do
	fslmaths \
	$subject_masks/${i}_seg.nii.gz \
	-mul $subject_masks/${i}_SMG.nii.gz \
	$subject_masks/${i}_SMG_seg.nii.gz

#calculate images for each tissue class
	fslmaths \
	$subject_masks/${i}_SMG_seg.nii.gz \
	-thr 3 \
	$subject_masks/${i}_SMG_wm.nii.gz

	fslmaths \
	$subject_masks/${i}_SMG_seg.nii.gz \
	-uthr 1 \
	$subject_masks/${i}_SMG_csf.nii.gz

	fslmaths \
	$subject_masks/${i}_SMG_seg.nii.gz \
	-sub $subject_masks/${i}_SMG_wm.nii.gz \
	-sub $subject_masks/${i}_SMG_csf.nii.gz \
	$subject_masks/${i}_SMG_gm.nii.gz

# calculate VOI volume non-zero voxels (output= voxels volume)
	SMG_VOL=`fslstats $subject_masks/${i}_SMG_seg.nii.gz -V`
	SMG_CSF=`fslstats $subject_masks/${i}_SMG_csf.nii.gz -V`
	SMG_GM=`fslstats $subject_masks/${i}_SMG_gm.nii.gz -V`
	SMG_WM=`fslstats $subject_masks/${i}_SMG_wm.nii.gz -V`

	echo ${i} $SMG_VOL $SMG_CSF $SMG_GM $SMG_WM >> $subject_masks/SMG_VOL_seg.txt
	done


for i in $(cat subjlist.txt); do
	fslmaths \
	$subject_masks/${i}_seg.nii.gz \
	-mul $subject_masks/${i}_FFG.nii.gz \
	$subject_masks/${i}_FFG_seg.nii.gz

#calculate images for each tissue class
	fslmaths \
	$subject_masks/${i}_FFG_seg.nii.gz \
	-thr 3 \
	$subject_masks/${i}_FFG_wm.nii.gz

	fslmaths \
	$subject_masks/${i}_FFG_seg.nii.gz \
	-uthr 1 \
	$subject_masks/${i}_FFG_csf.nii.gz

	fslmaths \
	$subject_masks/${i}_FFG_seg.nii.gz \
	-sub $subject_masks/${i}_FFG_wm.nii.gz \
	-sub $subject_masks/${i}_FFG_csf.nii.gz \
	$subject_masks/${i}_FFG_gm.nii.gz

# calculate VOI volume non-zero voxels (output= voxels volume)
	FFG_VOL=`fslstats $subject_masks/${i}_FFG_seg.nii.gz -V`
	FFG_CSF=`fslstats $subject_masks/${i}_FFG_csf.nii.gz -V`
	FFG_GM=`fslstats $subject_masks/${i}_FFG_gm.nii.gz -V`
	FFG_WM=`fslstats $subject_masks/${i}_FFG_wm.nii.gz -V`

	echo ${i} $FFG_VOL $FFG_CSF $FFG_GM $FFG_WM >> $subject_masks/FFG_VOL_seg.txt
	done

for i in $(cat subjlist.txt); do
	fslmaths \
	$subject_masks/${i}_seg.nii.gz \
	-mul $subject_masks/${i}_STG.nii.gz \
	$subject_masks/${i}_STG_seg.nii.gz

#calculate images for each tissue class
	fslmaths \
	$subject_masks/${i}_STG_seg.nii.gz \
	-thr 3 \
	$subject_masks/${i}_STG_wm.nii.gz

	fslmaths \
	$subject_masks/${i}_STG_seg.nii.gz \
	-uthr 1 \
	$subject_masks/${i}_STG_csf.nii.gz

	fslmaths \
	$subject_masks/${i}_STG_seg.nii.gz \
	-sub $subject_masks/${i}_STG_wm.nii.gz \
	-sub $subject_masks/${i}_STG_csf.nii.gz \
	$subject_masks/${i}_STG_gm.nii.gz

# calculate VOI volume non-zero voxels (output= voxels volume)
	STG_VOL=`fslstats $subject_masks/${i}_STG_seg.nii.gz -V`
	STG_CSF=`fslstats $subject_masks/${i}_STG_csf.nii.gz -V`
	STG_GM=`fslstats $subject_masks/${i}_STG_gm.nii.gz -V`
	STG_WM=`fslstats $subject_masks/${i}_STG_wm.nii.gz -V`

	echo ${i} $STG_VOL $STG_CSF $STG_GM $STG_WM >> $subject_masks/STG_VOL_seg.txt
	done
	