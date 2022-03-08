#!/bin/bash
#warp subjects' FOD images into template space
#segment each FOD lobe (computes AFD per fixel)
#reorient fixels in template space based on local transformation at each voxel
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix


cd /mrtrix_out/${1}
mrtransform wmfod_norm.mif -warp subject2template_warp.mif -reorient_fod no fod_in_template_space_NOT_REORIENTED.mif -nthreads 4 -debug
fod2fixel -mask ../template/template_mask.mif fod_in_template_space_NOT_REORIENTED.mif fixel_in_template_space_NOT_REORIENTED -afd fd.mif -nthreads 4 -debug
fixelreorient fixel_in_template_space_NOT_REORIENTED subject2template_warp.mif fixel_in_template_space -nthreads 4 -debug

#After this step, the fixel_in_template_space_NOT_REORIENTED folders can be safely removed.
