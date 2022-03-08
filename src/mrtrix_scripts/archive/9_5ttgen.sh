#!/bin/bash
#5 tissue type segmentation using FSL for ACT in mrtrix
#create mask for seeding on GM-WM interface, run before tckgen
#Meaghan Perdue May 2021


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix


cd /mrtrix_out/$subj
5ttgen fsl T1w_transformed.mif 5tt_anat.mif
5tt2gmwmi 5tt_anat.mif 5ttgmwmi.mif


