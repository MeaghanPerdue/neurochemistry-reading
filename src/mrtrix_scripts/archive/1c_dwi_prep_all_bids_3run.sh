#DWI preprocessing pipeline for A214 data using MRTrix3 & FSL
#Written by Meaghan Perdue, April 2019, updated April 2021 to BIDS format

export bids_dir=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data
export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

cd $bids_dir

#for 3x 3 min. run dwi acq
#creates a subject folder in the mrtrix directory and saves outputs to mrtrix/subj
#converts all dwi runs to .mif format 
#concats converted dwi runs into a single file, from this step, processing is identical to single run processing (topup/eddy handle registration/alignment automatically)
#performs mrtrix denoising, first step in DWI preproc
#following this step, do QC by visually inspecting residuals for lack of anatomy:
#mrview res.mif

#check whether subject data files end in .nii or .nii.gz and update scripts accordingly (Haskins data varied by subject)

for subj in $(cat subjlist_3run.txt)
do
	mkdir $mrtrix_out/$subj
	mkdir $mrtrix_out/$subj/preproc
	mrconvert $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.nii $mrtrix_out/$subj/preproc/dwi_run1.mif -fslgrad $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.bvec $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.bval -json_import $subj/ses-01/dwi/${subj}_ses-01_run-01_dwi.json -json_export $mrtrix_out/$subj/preproc/dwi_run1.json
	mrconvert $subj/ses-01/dwi/${subj}_ses-01_run-03_dwi.nii $mrtrix_out/$subj/preproc/dwi_run3.mif -fslgrad $subj/ses-01/dwi/${subj}_ses-01_run-03_dwi.bvec $subj/ses-01/dwi/${subj}_ses-01_run-03_dwi.bval -json_import $subj/ses-01/dwi/${subj}_ses-01_run-03_dwi.json -json_export $mrtrix_out/$subj/preproc/dwi_run3.json
	mrconvert $subj/ses-01/dwi/${subj}_ses-01_run-05_dwi.nii $mrtrix_out/$subj/preproc/dwi_run5.mif -fslgrad $subj/ses-01/dwi/${subj}_ses-01_run-05_dwi.bvec $subj/ses-01/dwi/${subj}_ses-01_run-05_dwi.bval -json_import $subj/ses-01/dwi/${subj}_ses-01_run-05_dwi.json -json_export $mrtrix_out/$subj/preproc/dwi_run5.json
	mrcat $mrtrix_out/$subj/preproc/dwi_run1.mif $mrtrix_out/$subj/preproc/dwi_run3.mif $mrtrix_out/$subj/preproc/dwi_run5.mif $mrtrix_out/$subj/preproc/dwi_raw.mif
	dwidenoise $mrtrix_out/$subj/preproc/dwi_raw.mif $mrtrix_out/$subj/preproc/dwi_denoise.mif -noise $mrtrix_out/$subj/preproc/noise.mif -info -debug
	mrcalc $mrtrix_out/$subj/preproc/dwi_raw.mif $mrtrix_out/$subj/preproc/dwi_denoise.mif -subtract $mrtrix_out/$subj/preproc/res.mif
done

#Gibbs Ringing correction via MRTrix3
#Run this after running denoising
#QC: visually compare input and output images for removal of Gibbs Ringing

for subj in $(cat subjlist_3run.txt)
do
	mrdegibbs $mrtrix_out/$subj/preproc/dwi_denoise.mif $mrtrix_out/$subj/preproc/dwi_degibbs.mif -info -debug
done

#DWI preprocessing steps including FSL's eddy correct (OpenMP version) and topup via MRTrix3 platform
#Creates a brain mask based on preprocessed DWI for use in speeding up subsequent analysis
#preprocessed DWI and mask saved to subject's derivatives/mrtrix folder

for subj in $(cat subjlist_3run.txt)
do
  	mrcat $subj/ses-01/fmap/${subj}_ses-01_dir-AP_epi.nii $subj/ses-01/fmap/${subj}_ses-01_dir-PA_epi.nii $mrtrix_out/$subj/preproc/b0s.mif -axis 3 
	dwifslpreproc $mrtrix_out/$subj/preproc/dwi_degibbs.mif $mrtrix_out/$subj/dwi_preprocessed.mif -rpe_pair -se_epi $mrtrix_out/$subj/preproc/b0s.mif -pe_dir ap -align_seepi -eddy_options "--slm=linear " -nthreads 6 -debug 
	dwi2mask $mrtrix_out/$subj/dwi_preprocessed.mif $mrtrix_out/$subj/mask.mif
done

echo Preprocessing is complete! Visually inspect res.mif and dwi_degibbs.mif of each subject before proceeding with analysis.
