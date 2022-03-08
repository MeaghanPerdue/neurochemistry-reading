#register each subject to fod template, warp masks to template space, compute template mask for further analysis
#script by Meaghan Perdue, April 2019
#cd /Volumes/EEG/a214/

for subj in $(cat subjlist2.txt)
	do
	mrregister $subj/wmfod_norm.mif -mask1 $subj/dwi_mask_upsampled.mif template/wmfod_template.mif -nl_warp $subj/subject2template_warp.mif $subj/template2subject_warp.mif
	mrtransform $subj/dwi_mask_upsampled.mif -warp $subj/subject2template_warp.mif -interp nearest -datatype bit $subj/dwi_mask_in_template_space.mif
	done
mrmath */dwi_mask_in_template_space.mif min template/template_mask.mif -datatype bit
echo "review template mask: mrview template/template_mask.mif"

