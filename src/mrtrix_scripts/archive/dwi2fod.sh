#multi-shell multi tissue CSD in mrtrix, using group average response estimates
#script by Meaghan Perdue, April 2019
#cd /Volumes/EEG/a214/
#upsample then dwi2fod

for subj in $(cat subjlist2.txt)
	do
	mrresize -voxel 1.3 $subj/dwi_preproc_biascorr.mif $subj/dwi_preproc_biascorr_upsampled.mif
	dwi2mask $subj/dwi_preproc_biascorr_upsampled.mif $subj/dwi_mask_upsampled.mif
	dwi2fod -mask $subj/dwi_mask_upsampled.mif -force msmt_csd $subj/dwi_preproc_biascorr_upsampled.mif wm_response_avg.txt $subj/wmfod.mif gm_response_avg.txt $subj/gm.mif csf_response_avg.txt $subj/csf.mif -info -debug
	mrconvert -force -coord 3 0 $subj/wmfod.mif - | mrcat -force $subj/csf.mif $subj/gm.mif - $subj/vf.mif
	done
 