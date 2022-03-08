#warp FOD images to template space
#segment FOD to identify num and orientation of fixels in each voxel, estimate AFD
#reorient fixels
#match subj fixels to template fixels
#script by Meaghan Perdue, April 2019
#cd /Volumes/EEG/a214/

for subj in $(cat subjlist2.txt)
	do
	#mrtransform -debug -force $subj/wmfod_norm.mif -warp $subj/subject2template_warp.mif -noreorientation $subj/fod_in_template_space_NOT_REORIENTED.mif
	#fod2fixel -debug -force -afd fd.mif -mask template/template_mask.mif $subj/fod_in_template_space_NOT_REORIENTED.mif $subj/fixel_in_template_space_NOT_REORIENTED 
 	#fixelreorient -debug $subj/fixel_in_template_space_NOT_REORIENTED $subj/subject2template_warp.mif $subj/fixel_in_template_space
  	fixelcorrespondence -force -debug $subj/fixel_in_template_space/fd.mif template/fixel_mask_18 template/fd $subj.mif
	done