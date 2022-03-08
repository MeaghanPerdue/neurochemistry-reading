#!/bin/bash
#multi-shell multi tissue CSD in mrtrix, using group average response estimates
#script by Meaghan Perdue, April 2019
#

#export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix



cd /mrtrix_out/${1}
dwi2fod msmt_csd dwi_preproc_upsampled.mif ../group_average_response_wm.txt wmfod.mif ../group_average_response_gm.txt gm.mif ../group_average_response_csf.txt csf.mif -mask dwi_preproc_upsampled_bet_mask.nii.gz -info -debug -nthreads 4
mrconvert -coord 3 0 wmfod.mif - | mrcat csf.mif gm.mif - vf.mif #outputs the rgb visualization of csd ellipsoids 

 
 #display WM FODs with tissue signal contribution map
 #mrview vf.mif -odf.load_sh wm.mif