#!/bin/bash
#create WM template analysis fixel mask
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

cd /mrtrix_out/

fod2fixel -mask template/template_mask.mif -fmls_peak_value 0.22 template/wmfod_template.mif template/fixel_mask -nthreads 16 -debug

#check number of fixels in the resulting mask by running mrinfo -size fixel_mask/directions.mif, it should be in the hundreds-of-thousands
#check output mask in mrview  by opening either the template wm_fod.mif or template_mask.mif, then open index.mif in template/fixel_mask using the fixel plot tool
#should show fixels everywhere that's expected to be WM
#on a214 data, it was far to liberal (>2 million), so adjusted from the default -fmls_peak_value by increasing. If areas of WM were missing, try a lower value