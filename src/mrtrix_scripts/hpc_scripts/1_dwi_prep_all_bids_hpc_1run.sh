#!/bin/bash
#DWI preprocessing pipeline for A214 data using MRTrix3 & FSL
#Written by Meaghan Perdue, April 2019, updated April 2021 to BIDS format

#export bids_dir=/scratch/mvm16101/a214_data
#export mrtrix_out=/scratch/mvm16101/a214_data/derivatives/mrtrix

export bids_dir=/bids_dir
export mrtrix_out=/mrtrix_out

cd $bids_dir

#for 9 min. run dwi acq
#creates a subject folder in the mrtrix directory and saves outputs to mrtrix/subj
#converts all dwi runs to .mif format 
#crops dwi runs for even number of slices (required for topup & eddy_qc to run properly)
#performs mrtrix denoising, first step in DWI preproc
#following this step, do QC by visually inspecting residuals for lack of anatomy:
#mrview res.mif

#check whether subject data files end in .nii.gz or .nii.gz.gz and update scripts accordingly (Haskins data varied by subject)
#note changes from version run for data collected & converted to nii at Haskins - here we have run-1, run-2 & run-3 instead of run-01, run-03, run-05 due to different dcm2nii config

mkdir $mrtrix_out/${1}
mkdir $mrtrix_out/${1}/preproc
mrconvert ${1}/ses-01/dwi/${1}_ses-01_run-01_dwi.nii.gz $mrtrix_out/${1}/preproc/dwi_raw.mif -fslgrad ${1}/ses-01/dwi/${1}_ses-01_run-01_dwi.bvec ${1}/ses-01/dwi/${1}_ses-01_run-01_dwi.bval -json_import ${1}/ses-01/dwi/${1}_ses-01_run-01_dwi.json -json_export $mrtrix_out/${1}/preproc/dwi_raw.json -force
mrgrid $mrtrix_out/${1}/preproc/dwi_raw.mif crop -axis 2 1,0 $mrtrix_out/${1}/preproc/dwi_cropped.mif -force
dwidenoise $mrtrix_out/${1}/preproc/dwi_cropped.mif $mrtrix_out/${1}/preproc/dwi_denoise.mif -noise $mrtrix_out/${1}/preproc/noise.mif -info -debug -force
mrcalc $mrtrix_out/${1}/preproc/dwi_raw.mif $mrtrix_out/${1}/preproc/dwi_denoise.mif -subtract $mrtrix_out/${1}/preproc/res.mif -force


#Gibbs Ringing correction via MRTrix3
#Run this after running denoising
#QC: visually compare input and output images for removal of Gibbs Ringing

mrdegibbs $mrtrix_out/${1}/preproc/dwi_denoise.mif $mrtrix_out/${1}/preproc/dwi_degibbs.mif -info -debug -force


#DWI preprocessing steps including FSL's eddy correct (OpenMP version) and topup via MRTrix3 platform
#Creates a brain mask based on preprocessed DWI for use in speeding up subsequent analysis
#preprocessed DWI and mask saved to subject's derivatives/mrtrix folder

mrcat $bids_dir/${1}/ses-01/fmap/${1}_ses-01_dir-AP_epi.nii.gz $bids_dir/${1}/ses-01/fmap/${1}_ses-01_dir-PA_epi.nii.gz $mrtrix_out/${1}/preproc/b0s.mif -axis 3 -force
dwifslpreproc $mrtrix_out/${1}/preproc/dwi_degibbs.mif $mrtrix_out/${1}/dwi_preprocessed.mif -rpe_pair -se_epi $mrtrix_out/${1}/preproc/b0s.mif -pe_dir ap -align_seepi -eddyqc_all ${1}/${1}.qc -nthreads 8 -debug -force -nocleanup
dwi2mask $mrtrix_out/${1}/dwi_preprocessed.mif $mrtrix_out/${1}/mask.mif -force

echo Preprocessing is complete! Visually inspect res.mif and dwi_degibbs.mif of each subject before proceeding with analysis.
