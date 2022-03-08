#intensity normalization and bias field correction
#required even if biascorrect was already done
#script by Meaghan Perdue, April 2019
#cd /Volumes/EEG/a214/


for subj in $(cat subjlist2.txt)
	do
	mtnormalise -mask $subj/dwi_mask_upsampled.mif $subj/wmfod.mif $subj/wmfod_norm.mif $subj/gm.mif $subj/gm_norm.mif $subj/csf.mif $subj/csf_norm.mif	
	done
 
