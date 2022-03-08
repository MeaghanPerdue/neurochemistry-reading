#create fixel masks of MRS voxels
#MP 2021
#uses MRS VOIs from sample subject 214035/sub-pa1277

export mrs_bids=/Volumes/Research/A214/MRS/bids
export mrs_masks=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrs_masks
export mrtrix_dir=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/template

#convert voxel masks to fixel masks

#first, regrid MRS mask image into wmfod template space
mrgrid -template $mrtrix_dir/wmfod_template.mif -interp nearest  $mrs_masks/sub-pa1277_SMG.nii.gz regrid $mrtrix_dir/sub-pa1277_SMG_regrid.mif 

mrgrid -template $mrtrix_dir/wmfod_template.mif -interp nearest  $mrs_masks/sub-pa1277_STG.nii.gz regrid $mrtrix_dir/sub-pa1277_STG_regrid.mif 

mrgrid -template $mrtrix_dir/wmfod_template.mif -interp nearest  $mrs_masks/sub-pa1277_FFG.nii.gz regrid $mrtrix_dir/sub-pa1277_FFG_regrid.mif 


#next, convert voxel image into fixel mask image (assign 1s to)
voxel2fixel $mrtrix_dir/sub-pa1277_SMG_regrid.mif $mrtrix_dir/fixel_mask_v3 $mrtrix_dir/SMG_fixel_mask SMG_fixel_mask.mif

voxel2fixel $mrtrix_dir/sub-pa1277_STG_regrid.mif $mrtrix_dir/fixel_mask_v3 $mrtrix_dir/STG_fixel_mask STG_fixel_mask.mif

voxel2fixel $mrtrix_dir/sub-pa1277_FFG_regrid.mif $mrtrix_dir/fixel_mask_v3 $mrtrix_dir/FFG_fixel_mask FFG_fixel_mask.mif