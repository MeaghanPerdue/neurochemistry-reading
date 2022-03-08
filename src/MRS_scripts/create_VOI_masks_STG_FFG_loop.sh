#!/bin/bash
# align t2 to t1
#for now it's set up to run relative to Haskins directories
#run this script by doing sh create_VOI_masks_STG_FFG_loop.sh MRS_ID MRI_ID
#depending on the subject, you'll need to select which mrs session and runs of the T1 and T2 to use
#naming of the trans.txt files varies a bid, so may need to use metabSTEAM or STEAM, if it throws an error, just check by listing the bids mrs directory

export anatbids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export mrs_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
export mrs_dir=/Volumes/Research/A214/MRS

cd $mrs_dir

#mrs2 T2-run1, T1-run1
# subject_masks/scripts/make_voi.py \
# 	--t1_nifti ../bids/${2}/ses-01/anat/${2}_ses-01_T1w.nii.gz \
# 	--t2_nifti bids/${1}/ses-mrs2/anat/${1}_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
# 	--svs_transform bids/${1}/ses-mrs2/mrs/${1}_ses-mrs2_nuc-1H_loc-STG_spec-metabSTEAM_run-1_trans.txt \
# 	--mflirt subject_masks/${2}_mrs2_ax2T1.mat --roi_prefix subject_masks/${2}_STG
# 
# subject_masks/scripts/make_voi.py \
# 	--t1_nifti ../bids/${2}/ses-01/anat/${2}_ses-01_T1w.nii.gz \
# 	--t2_nifti bids/${1}/ses-mrs2/anat/${1}_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
# 	--svs_transform bids/${1}/ses-mrs2/mrs/${1}_ses-mrs2_nuc-1H_loc-FFG_spec-metabSTEAM_run-1_trans.txt \
# 	--mflirt subject_masks/${2}_mrs2_ax2T1.mat --roi_prefix subject_masks/${2}_FFG
# 
#mrs1 T2-run1, T1 run1
subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/${2}/ses-01/anat/${2}_ses-01_T1w.nii.gz \
	--t2_nifti bids/${1}/ses-mrs1/anat/${1}_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/${1}/ses-mrs1/mrs/${1}_ses-mrs1_nuc-1H_loc-STG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/${2}_mrs1_ax2T1.mat --roi_prefix subject_masks/${2}_STG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/${2}/ses-01/anat/${2}_ses-01_T1w.nii.gz \
	--t2_nifti bids/${1}/ses-mrs1/anat/${1}_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/${1}/ses-mrs1/mrs/${1}_ses-mrs1_nuc-1H_loc-FFG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/${2}_mrs1_ax2T1.mat --roi_prefix subject_masks/${2}_FFG

#mrs1 T2-run2	
# subject_masks/scripts/make_voi.py \
# 	--t1_nifti ../bids/${2}/ses-01/anat/${2}_ses-01_T1w.nii.gz \
# 	--t2_nifti bids/${1}/ses-mrs1/anat/${1}_ses-mrs1_acq-AxialScout_run-2_T2w.nii.gz \
# 	--svs_transform bids/${1}/ses-mrs1/mrs/${1}_ses-mrs1_nuc-1H_loc-STG_spec-STEAM_run-1_trans.txt \
# 	--mflirt subject_masks/${2}_mrs1_run2_ax2T1.mat --roi_prefix subject_masks/${2}_STG
# 
# subject_masks/scripts/make_voi.py \
# 	--t1_nifti ../bids/${2}/ses-01/anat/${2}_ses-01_T1w.nii.gz \
# 	--t2_nifti bids/${1}/ses-mrs1/anat/${1}_ses-mrs1_acq-AxialScout_run-2_T2w.nii.gz \
# 	--svs_transform bids/${1}/ses-mrs1/mrs/${1}_ses-mrs1_nuc-1H_loc-FFG_spec-STEAM_run-1_trans.txt \
# 	--mflirt subject_masks/${2}_mrs1_run2_ax2T1.mat --roi_prefix subject_masks/${2}_FFG