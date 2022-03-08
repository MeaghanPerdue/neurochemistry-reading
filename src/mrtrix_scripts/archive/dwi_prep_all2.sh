#DWI preprocessing pipeline for A214 data using MRTrix3 & FSL
#Written by Meaghan Perdue, April 2019, updated April 2021

#cd /Volumes/EEG/a214/ --> from when data was on Drobo

cd /Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data

#mrtrix denoising, first step in DWI preproc
#this script is for data acquired with reverse phase encoding for all DWIs, first converts to .mif format 
#also creates a subject folder in the mrtrix directory and saves outputs to mrtrix/subj 
#following this step, do QC by visually inspecting residuals for lack of anatomy:
#mrview res.mif

for subj in $(cat subjlist2.txt)
do
	mkdir $subj/dwi/preproc
	mrconvert $subj/dwi/*dwi.nii.gz $subj/dwi/preproc/dwi_raw.mif -fslgrad $subj/dwi/*.bvec $subj/dwi/*.bval -json_import $subj/dwi/*dwi.json -json_export $subj/dwi/preproc/dwi.json
	dwidenoise $subj/dwi/preproc/dwi_raw.mif $subj/dwi/preproc/dwi_denoise.mif -noise $subj/dwi/preproc/noise.mif -info -debug
	mrcalc $subj/dwi/preproc/dwi_raw.mif $subj/dwi/preproc/dwi_denoise.mif -subtract $subj/dwi/preproc/res.mif
done

#Gibbs Ringing correction via MRTrix3
#Run this after running denoising
#QC: visually compare input and output images for removal of Gibbs Ringing

cd mrtrix

for subj in $(cat subjlist2.txt)
do
	mrdegibbs $subj/dwi/preproc/dwi_denoise.mif $subj/dwi/preproc/dwi_degibbs.mif -info -debug
done

#DWI preprocessing steps including FSL's eddy correct (OpenMP version) and topup via MRTrix3 platform
#Creates a brain mask based on preprocessed DWI for use in speeding up subsequent analysis
#preprocessed DWI and mask saved to subject's main folder

for subj in $(cat subjlist2.txt)
do
	dwipreproc $subj/dwi/preproc/dwi_degibbs.mif $subj/dwi/dwi_preprocessed.mif -rpe_header -export_grad_fsl $subj/dwi/bvecs $subj/dwi/bvals -debug
	dwi2mask $subj/dwi/dwi_preprocessed.mif $subj/mask.mif
done

echo Preprocessing is complete! Visually inspect res.mif and dwi_degibbs.mif of each subject before proceeding with analysis.
