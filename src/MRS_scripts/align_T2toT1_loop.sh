#!/bin/bash
# align t2 to t1
#for now it's set up to run relative to Haskins directories
export anatbids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export mrs_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
export mrs_dir=/Volumes/Research/A214/MRS

cd $mrs_dir

#mrs1 run1
for i in $(cat MRS_subs.txt); do
	flirt \
		-in bids/${i}/ses-mrs1/anat/${i}_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
		-ref $anatbids/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
		-out subject_masks/${i}_mrs1_ax2T1.nii.gz \
		-omat subject_masks/${i}_mrs1_ax2T1.mat \
		-bins 256 -cost mutualinfo \
		-searchrx -180 180 -searchry -180 180 -searchrz -180 180 \
		-dof 6 -interp trilinear
	cp subject_masks/${i}_mrs1_ax2T1* $mrs_masks
	done


# for i in $(cat MRS_subs.txt); do	
# 	flirt \
# 		-in bids/${i}/ses-mrs2/anat/${i}_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
# 		-ref ../bids/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
# 		-out subject_masks/${i}_mrs2_ax2T1.nii.gz \
# 		-omat subject_masks/${i}_mrs2_ax2T1.mat \
# 		-bins 256 -cost mutualinfo \
# 		-searchrx -180 180 -searchry -180 180 -searchrz -180 180 \
# 		-dof 6 -interp trilinear
# 	cp subject_masks/${i}_mrs2_ax2T1* $mrs_masks
# 	done