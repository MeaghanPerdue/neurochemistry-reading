#!/bin/bash
# align t2 to t1
#for now it's set up to run relative to Haskins directories
export anatbids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export mrs_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
export mrs_dir=/Volumes/Research/A214/MRS

cd $mrs_dir

#mrs1 SMG
for i in $(cat MRS_subs.txt); do	
# 	subject_masks/scripts/make_voi.py \
# 		--t1_nifti ../bids/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
# 		--t2_nifti bids/${i}/ses-mrs1/anat/${i}_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
# 		--svs_transform bids/${i}/ses-mrs1/mrs/${i}_ses-mrs1_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
# 		--mflirt subject_masks/${i}_mrs1_ax2T1.mat --roi_prefix subject_masks/${i}_SMG
	subject_masks/scripts/make_voi.py \
		--t1_nifti ../bids/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
		--t2_nifti bids/${i}/ses-mrs2/anat/${i}_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
		--svs_transform bids/${i}/ses-mrs2/mrs/${i}_ses-mrs2_nuc-1H_loc-STG_spec-STEAM_run-1_trans.txt \
		--mflirt subject_masks/${i}_mrs2_ax2T1.mat --roi_prefix subject_masks/${i}_STG
	subject_masks/scripts/make_voi.py \
		--t1_nifti ../bids/${i}/ses-01/anat/${i}_ses-01_T1w.nii.gz \
		--t2_nifti bids/${i}/ses-mrs2/anat/${i}_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
		--svs_transform bids/${i}/ses-mrs2/mrs/${i}_ses-mrs2_nuc-1H_loc-FFG_spec-STEAM_run-1_trans.txt \
		--mflirt subject_masks/${i}_mrs2_ax2T1.mat --roi_prefix subject_masks/${i}_FFG
		done
	