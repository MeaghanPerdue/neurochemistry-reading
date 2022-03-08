#create fixel masks of MRS voxels
#MP 2021
#uses MRS VOIs from sample subject 214035/sub-pa1277

# export mrs_bids=/Volumes/Research/A214/MRS/bids
# export mrs_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
# export mrtrix_dir=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/template
# 
# 
# #register T2s to wmfod_template following the same method used to align subject's T2s to T1s
# flirt \
# 	-in $mrs_bids/sub-214035/ses-mrs1/anat/sub-214035_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
# 	-ref $mrtrix_dir/wmfod_template_3D.nii.gz \
# 	-out $mrtrix_dir/sub-214035_mrs1_ax2template.nii.gz \
# 	-omat $mrtrix_dir/sub-214035_mrs1_ax2template.mat \
# 	-bins 256 -cost mutualinfo \
# 	-searchrx -180 180 -searchry -180 180 -searchrz -180 180 \
# 	-dof 6 -interp trilinear
# 
# flirt \
# 	-in $mrs_bids/sub-214035/ses-mrs2/anat/sub-214035_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
# 	-ref $mrtrix_dir/wmfod_template_3D.nii.gz \
# 	-out $mrtrix_dir/sub-214035_mrs2_ax2template.nii.gz \
# 	-omat $mrtrix_dir/sub-214035_mrs2_ax2template.mat \
# 	-bins 256 -cost mutualinfo \
# 	-searchrx -180 180 -searchry -180 180 -searchrz -180 180 \
# 	-dof 6 -interp trilinear


^THIS DID NOT WORK! ROI masks look fine when just loaded raw as overlays over the wmfod mask so go with that!


#create VOIs in space of wmfod template
source activate bruker

export mrs_bids=/Volumes/Research/A214/MRS/bids
export mrs_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
export mrtrix_dir=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/template


/Volumes/Research/A214/MRS/bids/subject_masks/scripts/make_voi.py \
	--t1_nifti $mrtrix_dir/wmfod_template_3D.nii.gz \
	--t2_nifti $mrs_bids/sub-214035/ses-mrs1/anat/sub-214035_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform $mrs_bids/sub-214035/ses-mrs1/mrs/sub-214035_ses-mrs1_nuc-1H_loc-STG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt $mrtrix_dir/sub-214035_mrs1_ax2template.mat \
	--roi_prefix $mrtrix_dir/sub-214035_STG_reg2template

/Volumes/Research/A214/MRS/bids/subject_masks/scripts/make_voi.py \
	--t1_nifti $mrtrix_dir/wmfod_template_3D.nii.gz \
	--t2_nifti $mrs_bids/sub-214035/ses-mrs1/anat/sub-214035_ses-mrs1_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform $mrs_bids/sub-214035/ses-mrs1/mrs/sub-214035_ses-mrs1_nuc-1H_loc-FFG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt $mrtrix_dir/sub-214035_mrs1_ax2template.mat \
	--roi_prefix $mrtrix_dir/sub-214035_FFG_reg2template
	
/Volumes/Research/A214/MRS/bids/subject_masks/scripts/make_voi.py \
	--t1_nifti $mrtrix_dir/wmfod_template_3D.nii.gz \
	--t2_nifti $mrs_bids/sub-214035/ses-mrs2/anat/sub-214035_ses-mrs2_acq-AxialScout_run-1_T2w.nii.gz \
	--svs_transform $mrs_bids/sub-214035/ses-mrs2/mrs/sub-214035_ses-mrs2_nuc-1H_loc-SMG_spec-metabSTEAM_run-1_trans.txt \
	--mflirt $mrtrix_dir/sub-214035_mrs2_ax2template.mat \
	--roi_prefix $mrtrix_dir/sub-214035_SMG_reg2template
	
	




#convert voxel masks to fixel masks
