#!/bin/bash
#create VOI masks

# export bids=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
# export subject_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks

#directories relative to /Volumes/Research/A214/MRS

cd /Volumes/Research/A214/MRS


subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0394/ses-01/anat/sub-pa0394_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214008/ses-mrs2/anat/sub-214008_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214008/ses-mrs2/mrs/sub-214008_ses-mrs2_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0394_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa0394_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0393/ses-01/anat/sub-pa0393_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214010/ses-mrs1/anat/sub-214010_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214010/ses-mrs1/mrs/sub-214010_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0393_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0393_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0498/ses-01/anat/sub-pa0498_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214012/ses-mrs1/anat/sub-214012_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214012/ses-mrs1/mrs/sub-214012_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0498_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0498_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0579/ses-01/anat/sub-pa0579_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214016/ses-mrs1/anat/sub-214016_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214016/ses-mrs1/mrs/sub-214016_ses-mrs1_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0579_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0579_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0924/ses-01/anat/sub-pa0924_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214031/ses-mrs1/anat/sub-214031_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214031/ses-mrs1/mrs/sub-214031_ses-mrs1_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0924_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0924_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1454/ses-01/anat/sub-pa1454_ses-01_run-02_T1w.nii.gz \
	--t2_nifti bids/sub-214043/ses-mrs1/anat/sub-214043_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214043/ses-mrs1/mrs/sub-214043_ses-mrs1_nuc-1H_loc-SMG_spec-waterSTEAM_run-2_trans.txt \
	--mflirt subject_masks/sub-pa1454_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa1454_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa2045/ses-01/anat/sub-pa2045_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214047/ses-mrs1/anat/sub-214047_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214047/ses-mrs1/mrs/sub-214047_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa2045_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa2045_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa2015/ses-01/anat/sub-pa2015_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214048/ses-mrs1/anat/sub-214048_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214048/ses-mrs1/mrs/sub-214048_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa2015_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa2015_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1659/ses-01/anat/sub-pa1659_ses-01_T1w.nii \
	--t2_nifti bids/sub-214052/ses-mrs1/anat/sub-214052_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214052/ses-mrs1/mrs/sub-214052_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1659_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa1659_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-214056/ses-01/anat/sub-214056_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214056/ses-mrs1/anat/sub-214056_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214056/ses-mrs1/mrs/sub-214056_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-214056_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-214056_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0655/ses-01/anat/sub-pa0655_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214018/ses-mrs1/anat/sub-214018_ses-mrs1_acq-AxialScout_run-4_T2w.nii.gz \
	--svs_transform bids/sub-214018/ses-mrs1/mrs/sub-214018_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-2_trans.txt \
	--mflirt subject_masks/sub-pa0655_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0655_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0726/ses-01/anat/sub-pa0726_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214020/ses-mrs1/anat/sub-214020_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214020/ses-mrs1/mrs/sub-214020_ses-mrs1_nuc-1H_loc-SMG_spec-waterSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0726_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0726_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0727/ses-01/anat/sub-pa0727_ses-01_run-01_T1w.nii.gz \
	--t2_nifti bids/sub-214021/ses-mrs1/anat/sub-214021_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214021/ses-mrs1/mrs/sub-214021_ses-mrs1_nuc-1H_loc-SMG_spec-waterSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0727_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0727_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0923/ses-01/anat/sub-pa0923_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214028/ses-mrs1/anat/sub-214028_ses-mrs1_acq-AxialScout_run-2_T2w.nii.gz \
	--svs_transform bids/sub-214028/ses-mrs1/mrs/sub-214028_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0923_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0923_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0769/ses-01/anat/sub-pa0769_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214022/ses-mrs2/anat/sub-214022_ses-mrs2_acq-AxialScout_run-2_T2w.nii.gz \
	--svs_transform bids/sub-214022/ses-mrs2/mrs/sub-214022_ses-mrs2_nuc-1H_loc-SMG_spec-waterSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0769_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa0769_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0981/ses-01/anat/sub-pa0981_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214026/ses-mrs2/anat/sub-214026_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214026/ses-mrs2/mrs/sub-214026_ses-mrs2_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0981_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa0981_SMG
	
subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1057/ses-01/anat/sub-pa1057_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214027/ses-mrs2/anat/sub-214027_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214027/ses-mrs2/mrs/sub-214027_ses-mrs2_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1057_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa1057_SMG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1277/ses-01/anat/sub-pa1277_ses-01_T1w.nii \
	--t2_nifti bids/sub-214035/ses-mrs2/anat/sub-214035_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214035/ses-mrs2/mrs/sub-214035_ses-mrs2_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1277_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa1277_SMG

#redo with mrs2
subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1454/ses-01/anat/sub-pa1454_ses-01_run-02_T1w.nii.gz \
	--t2_nifti bids/sub-214043/ses-mrs2/anat/sub-214043_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214043/ses-mrs2/mrs/sub-214043_ses-mrs2_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1454_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa1454_SMG


subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1277/ses-01/anat/sub-pa1277_ses-01_T1w.nii \
	--t2_nifti bids/sub-214035/ses-mrs2/anat/sub-214035_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214035/ses-mrs2/mrs/sub-214035_ses-mrs2_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1277_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa1277_SMG

subject_masks/scripts/make_voi.py \
		--t1_nifti ../bids/sub-214061/ses-01/anat/sub-214061_ses-01_T1w.nii.gz \
		--t2_nifti bids/sub-214061/ses-mrs1/anat/sub-214061_ses-mrs1_acq-AxialScout_run-2_T2w.nii.gz \
		--svs_transform bids/sub-214061/ses-mrs1/mrs/sub-214061_ses-mrs1_nuc-1H_loc-STG_spec-metabSTEAM_run-2_trans.txt \
		--mflirt subject_masks/sub-214061_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-214061_STG
	
subject_masks/scripts/make_voi.py \
		--t1_nifti ../bids/sub-214061/ses-01/anat/sub-214061_ses-01_T1w.nii.gz \
		--t2_nifti bids/sub-214061/ses-mrs1/anat/sub-214061_ses-mrs1_acq-AxialScout_run-2_T2w.nii.gz \
		--svs_transform bids/sub-214061/ses-mrs1/mrs/sub-214061_ses-mrs1_nuc-1H_loc-FFG_spec-metabSTEAM_run-1_trans.txt \
		--mflirt subject_masks/sub-214061_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-214061_FFG

#sub-214043 had issues with file names for STG/SMG - STG collected on day 1 with IFG and SFG
subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1454/ses-01/anat/sub-pa1454_ses-01_run-02_T1w.nii.gz \
	--t2_nifti bids/sub-214043/ses-mrs2/anat/sub-214043_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214043/ses-mrs2/mrs/sub-214043_ses-mrs2_nuc-1H_loc-FFG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1454_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa1454_FFG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa1454/ses-01/anat/sub-pa1454_ses-01_run-02_T1w.nii.gz \
	--t2_nifti bids/sub-214043/ses-mrs1/anat/sub-214043_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214043/ses-mrs1/mrs/sub-214043_ses-mrs1_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa1454_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa1454_STG


subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0655/ses-01/anat/sub-pa0655_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214018/ses-mrs1/anat/sub-214018_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214018/ses-mrs1/mrs/sub-214018_ses-mrs1_nuc-1H_loc-STG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0655_mrs1_run1_ax2T1.mat --roi_prefix subject_masks/sub-pa0655_STG_run1


subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0394/ses-01/anat/sub-pa0394_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214008/ses-mrs2/anat/sub-214008_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214008/ses-mrs1/mrs/sub-214008_ses-mrs1_nuc-1H_loc-FFG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0394_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa0394_FFG


subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-pa0496/ses-01/anat/sub-pa0496_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214009/ses-mrs1/anat/sub-214009_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214009/ses-mrs1/mrs/sub-214009_ses-mrs1_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0496_mrs1_run1_ax2T1.mat --roi_prefix subject_masks/sub-pa0496_SMG_run1


subject_masks/scripts/make_voi.py \
	--t1_nifti subject_masks/sub-pa0981_ses-01_T1w_swapdim.nii.gz \
	--t2_nifti bids/sub-214026/ses-mrs2/anat/sub-214026_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214026/ses-mrs2/mrs/sub-214026_ses-mrs2_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0981_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-pa0981_SMG
	
subject_masks/scripts/make_voi.py \
	--t1_nifti subject_masks/sub-pa0981_ses-01_T1w_swapdim.nii.gz \
	--t2_nifti bids/sub-214026/ses-mrs1/anat/sub-214026_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214026/ses-mrs1/mrs/sub-214026_ses-mrs1_nuc-1H_loc-STG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0981_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0981_STG

subject_masks/scripts/make_voi.py \
	--t1_nifti subject_masks/sub-pa0981_ses-01_T1w_swapdim.nii.gz \
	--t2_nifti bids/sub-214026/ses-mrs1/anat/sub-214026_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214026/ses-mrs1/mrs/sub-214026_ses-mrs1_nuc-1H_loc-FFG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-pa0981_mrs1_ax2T1.mat --roi_prefix subject_masks/sub-pa0981_FFG


subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-214081/ses-01/anat/sub-214081_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214081/ses-mrs1/anat/sub-214081_ses-mrs1_acq-AxialScout_run-2_T2w.nii.gz \
	--svs_transform bids/sub-214081/ses-mrs1/mrs/sub-214081_ses-mrs1_nuc-1H_loc-SMG_spec-STEAM_run-3_trans.txt \
	--mflirt subject_masks/sub-214081_mrs1_run2_ax2T1.mat --roi_prefix subject_masks/sub-214081_SMG



subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-214065/ses-01/anat/sub-214065_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214065/ses-mrs2/anat/sub-214065_ses-mrs2_acq-AxialScout_run-3_T2w.nii.gz \
	--svs_transform bids/sub-214065/ses-mrs2/mrs/sub-214065_ses-mrs2_nuc-1H_loc-STG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-214065_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-214065_STG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-214065/ses-01/anat/sub-214065_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214065/ses-mrs2/anat/sub-214065_ses-mrs2_acq-AxialScout_run-3_T2w.nii.gz \
	--svs_transform bids/sub-214065/ses-mrs2/mrs/sub-214065_ses-mrs2_nuc-1H_loc-FFG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-214065_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-214065_FFG

subject_masks/scripts/make_voi.py \
	--t1_nifti ../bids/sub-214061/ses-01/anat/sub-214061_ses-01_T1w.nii.gz \
	--t2_nifti bids/sub-214061/ses-mrs2/anat/sub-214061_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform bids/sub-214061/ses-mrs2/mrs/sub-214061_ses-mrs2_nuc-1H_loc-SMG_spec-STEAM_run-1_trans.txt \
	--mflirt subject_masks/sub-214061_mrs2_ax2T1.mat --roi_prefix subject_masks/sub-214061_SMG
