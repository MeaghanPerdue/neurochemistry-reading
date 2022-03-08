#!/bin/bash
#Meaghan Perdue 05-31-2021
#eddy qc data prep and script for a214 mrtrix-processed data
#Converts/renames mrtrix fslpreproc output files to format readable by eddy_quad
#runs eddy_quad single subject level QC
#run locally, eddy_quad didn't seem to work in the container

export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix
export acqparam=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/acqparam.txt
export index=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/index3run.txt

cd $mrtrix_out

for i in $(cat subjlist3run.txt); do
	cd $i
	mrconvert dwi_preprocessed.mif ${i}.qc/${i}.nii.gz -export_grad_fsl ${i}.qc/${i}_dwi_preprocessed.bvec ${i}.qc/${i}_dwi_preprocessed.bval
	mrconvert mask.mif ${i}.qc/${i}_mask.nii.gz
	cd ${i}.qc
	mv eddy_mask.nii ${i}.eddy_mask.nii
	mv eddy_movement_rms ${i}.eddy_movement_rms
	mv eddy_outlier_map ${i}.eddy_outlier_map
	mv eddy_outlier_n_sqr_stdev_map ${i}.eddy_outlier_n_sqr_stdev_map
	mv eddy_outlier_n_stdev_map ${i}.eddy_outlier_n_stdev_map
	mv eddy_outlier_report ${i}.eddy_outlier_report
	mv eddy_parameters ${i}.eddy_parameters
	mv eddy_post_eddy_shell_PE_translation_parameters ${i}.eddy_post_eddy_shell_PE_translation_parameters
	mv eddy_post_eddy_shell_alignment_parameters ${i}.eddy_post_eddy_shell_alignment_parameters
	mv eddy_restricted_movement_rms ${i}.eddy_restricted_movement_rms
	eddy_quad ${i} -idx $index -par $acqparam -m ${i}_mask.nii.gz -b ${i}_dwi_preprocessed.bval
	cd $mrtrix_out
	done
	