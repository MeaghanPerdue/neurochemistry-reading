#!/bin/bash
#run eddy_quad QC on preprocessed dwi data
#script by Meaghan Perdue 5-13-21
SUBJ=$1

cd /mrtrix_out/${SUBJ}

#first convert preprocessed dwi and mask .mif files into .nii.gz with fsl-style bval/bvec files so they can be read by fsl
mrconvert -export_grad_fsl dwi_preprocessed.bvec dwi_preprocessed.bval dwi_preprocessed.mif dwi_preprocessed.nii.gz
mrconvert mask.mif mask.nii.gz
	
#next run subject-level eddy_quad
eddy_quad dwi_preprocessed -idx /scratch/index.txt -par /scratch/acqparam.txt -m mask.nii.gz -b dwi_preprocessed.bval -o ${SUBJ}_dwi_preprocessed.qc

