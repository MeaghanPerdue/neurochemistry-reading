#DWI preprocessing pipeline for A214 data using MRTrix3 & FSL
#Written by Meaghan Perdue, April 2019

#cd /Volumes/EEG/a214/

export OMP_NUM_THREADS=4

#mrtrix denoising, first step in DWI preproc
#this script is for data acquired with reverse phase encoding for all DWIs, first converts to .mif format 
#also creates a subject folder in the mrtrix directory and saves outputs to mrtrix/subj 
#following this step, do QC by visually inspecting residuals for lack of anatomy:
#mrview res.mif

# for subj in $(cat subjlist.txt)
# do
# 	mkdir $subj/preproc
# 	mrconvert $subj/*dwi.nii.gz $subj/preproc/dwi_raw.mif -fslgrad $subj/*.bvec $subj/*.bval -json_import $subj/*dwi.json -json_export $subj/preproc/dwi.json
# 	mrcat $subj/fmap/*AP_epi.nii.gz $subj/fmap/*PA_epi.nii.gz $subj/preproc/b0s.mif
# 	dwidenoise $subj/preproc/dwi_raw.mif $subj/preproc/dwi_denoise.mif -noise $subj/preproc/noise.mif -info -debug
# 	mrcalc $subj/preproc/dwi_raw.mif $subj/preproc/dwi_denoise.mif -subtract $subj/preproc/res.mif
# done

#Gibbs Ringing correction via MRTrix3
# Run this after running denoising
# QC: visually compare input and output images for removal of Gibbs Ringing

# for subj in $(cat subjlist.txt)
# do
# 	mrdegibbs $subj/preproc/dwi_denoise.mif $subj/preproc/dwi_degibbs.mif -info -debug
# done

#DWI preprocessing steps including FSL's eddy correct (OpenMP version) and topup via MRTrix3 platform
#runs bias correction
#Creates a brain mask based on preprocessed DWI for use in speeding up subsequent analysis
#preprocessed DWI and mask saved to subject's main folder

for subj in $(cat subjlist.txt)
do
	dwipreproc $subj/preproc/dwi_degibbs.mif $subj/preproc/dwi_preprocessed.mif -pe_dir AP -rpe_pair -se_epi $subj/preproc/b0s.mif -export_grad_fsl $subj/bvecs $subj/bvals -eddy_options " --slm=linear " -eddyqc_all $subj/preproc/eddyqc -debug
	# dwibiascorrect -ants $subj/preproc/dwi_preprocessed.mif $subj/dwi_preproc_biascorr.mif
# 	dwi2mask $subj/dwi_preproc_biascorr.mif $subj/mask.mif
done

# echo Preprocessing is complete! Visually inspect res.mif and dwi_degibbs.mif of each subject before proceeding with analysis.

