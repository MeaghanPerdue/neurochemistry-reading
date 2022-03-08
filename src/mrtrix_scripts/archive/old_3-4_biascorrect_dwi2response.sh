#!/bin/bash
#run mrtrix bias correction
#resample data
#create mask based on upsampled image
#dwi response estimation in mrtrix using dhollandar method (for multi-shell, multi-tissue CSD)


#export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix


cd /mrtrix_out/${1}
dwibiascorrect ants dwi_preprocessed.mif dwi_preproc_biascorr.mif -debug -force
dwi2response dhollander -voxels voxels.mif dwi_preproc_biascorr.mif wm_response.txt gm_response.txt csf_response.txt -debug -force
mrgrid dwi_preproc_biascorr.mif regrid -vox 1.25 dwi_preproc_biascorr_upsampled.mif -debug -force
dwi2mask dwi_preproc_biascorr_upsampled.mif dwi_mask_upsampled.mif -debug -force

#check mask for holes
