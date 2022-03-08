#DWI preprocessing pipeline for A214 data using MRTrix3 & FSL
#Written by Meaghan Perdue, April 2019, updated April 2021 to BIDS format

export bids_dir=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

cd $bids_dir

#for single 9 min. run dwi acq

#mrtrix denoising, first step in DWI preproc
#this script is for data acquired with reverse phase encoding for all DWIs, first converts to .mif format 
#also creates a subject folder in the mrtrix directory and saves outputs to mrtrix/subj 
#following this step, do QC by visually inspecting residuals for lack of anatomy:
#mrview res.mif

# for subj in $(cat subjlist_2runs.txt)
# do
# 	mkdir $mrtrix_out/$subj
# 	mkdir $mrtrix_out/$subj/preproc
# 	mrconvert $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.nii.gz $mrtrix_out/$subj/preproc/dwi_run1_raw.mif -fslgrad $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.bvec $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.bval -json_import $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.json -json_export $mrtrix_out/$subj/preproc/dwi_run1.json
# 	dwidenoise $mrtrix_out/$subj/preproc/dwi_run1_raw.mif $mrtrix_out/$subj/preproc/dwi_run1_denoise.mif -noise $mrtrix_out/$subj/preproc/noise_run1.mif -info -debug
# 	mrcalc $mrtrix_out/$subj/preproc/dwi_run1_raw.mif $mrtrix_out/$subj/preproc/dwi_run1_denoise.mif -subtract $mrtrix_out/$subj/preproc/res_run1.mif
# 	mrconvert $subj/ses-01/dwi/${subj}_ses-01_run-02_dwi.nii.gz $mrtrix_out/$subj/preproc/dwi_run2_raw.mif -fslgrad $subj/ses-01/dwi/${subj}_ses-01_run-02_dwi.bvec $subj/ses-01/dwi/${subj}_ses-01_run-02_dwi.bval -json_import $subj/ses-01/dwi/${subj}_ses-01_run-02_dwi.json -json_export $mrtrix_out/$subj/preproc/dwi_run2.json
# 	dwidenoise $mrtrix_out/$subj/preproc/dwi_run2_raw.mif $mrtrix_out/$subj/preproc/dwi_run2_denoise.mif -noise $mrtrix_out/$subj/preproc/noise_run2.mif -info -debug
# 	mrcalc $mrtrix_out/$subj/preproc/dwi_run2_raw.mif $mrtrix_out/$subj/preproc/dwi_run2_denoise.mif -subtract $mrtrix_out/$subj/preproc/res_run2.mif
# done

#Gibbs Ringing correction via MRTrix3
#Run this after running denoising
#QC: visually compare input and output images for removal of Gibbs Ringing

# for subj in $(cat subjlist_2runs.txt)
# do
# 	#mrdegibbs $mrtrix_out/$subj/preproc/dwi_run1_denoise.mif $mrtrix_out/$subj/preproc/dwi_run1_degibbs.mif -info -debug
# 	mrdegibbs $mrtrix_out/$subj/preproc/dwi_run2_denoise.mif $mrtrix_out/$subj/preproc/dwi_run2_degibbs.mif -info -debug
# done

#DWI preprocessing steps including FSL's eddy correct (OpenMP version) and topup via MRTrix3 platform
#Creates a brain mask based on preprocessed DWI for use in speeding up subsequent analysis
#preprocessed DWI and mask saved to subject's derivatives/mrtrix folder
#selected which run to use for further processing based on QC of res. and degibbs, all but 1 subject should have run 1 processed:


for subj in $(cat subjlist_2runs.txt)
do
 	#mrcat $subj/ses-01/fmap/${subj}_ses-01_dir-AP_epi.nii.gz $subj/ses-01/fmap/${subj}_ses-01_dir-PA_epi.nii.gz $mrtrix_out/$subj/preproc/b0s.mif -axis 3
	dwifslpreproc $mrtrix_out/$subj/preproc/dwi_run1_degibbs.mif $mrtrix_out/$subj/dwi_preprocessed.mif -rpe_pair -se_epi $mrtrix_out/$subj/preproc/b0s.mif -pe_dir ap -align_seepi -nthreads 6 -debug
	dwi2mask $mrtrix_out/$subj/dwi_preprocessed.mif $mrtrix_out/$subj/mask.mif
done

for subj in sub-pa0310
do
 	#mrcat $subj/ses-01/fmap/${subj}_ses-01_dir-AP_epi.nii.gz $subj/ses-01/fmap/${subj}_ses-01_dir-PA_epi.nii.gz $mrtrix_out/$subj/preproc/b0s.mif -axis 3
	dwifslpreproc $mrtrix_out/$subj/preproc/dwi_run2_degibbs.mif $mrtrix_out/$subj/dwi_preprocessed.mif -rpe_pair -se_epi $mrtrix_out/$subj/preproc/b0s.mif -pe_dir ap -align_seepi -nthreads 6 -debug
	dwi2mask $mrtrix_out/$subj/dwi_preprocessed.mif $mrtrix_out/$subj/mask.mif
done

echo Preprocessing is complete! Visually inspect res.mif and dwi_degibbs.mif of each subject before proceeding with analysis.

