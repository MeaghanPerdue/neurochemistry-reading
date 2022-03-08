#!/bin/bash
#create group average response files for each tissue compartment

#export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix
cd /mrtrix_out

responsemean /mrtrix_out/*/wm_response.txt /mrtrix_out/group_average_response_wm.txt  
responsemean /mrtrix_out/*/gm_response.txt /mrtrix_out/group_average_response_gm.txt  
responsemean /mrtrix_out/*/csf_response.txt	/mrtrix_out/group_average_response_csf.txt
