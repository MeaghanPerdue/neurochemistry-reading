#whole brain tractography using probabilistic ACT
#script by Meaghan Perdue, April 2020

for subj in $(cat subjlist2.txt)
	do
	#5tt2vis $subj/5tt_anat.mif $subj/5ttvis.mif
	# mrconvert $subj/5tt_anat.mif -coord 3 2 -axes 0,1,2 - | \
# 	mrthreshold - -abs 0.001 $subj/wm_seed.mif
	tckgen -algorithm iFOD2 -select 100k -seed_image $subj/wm_seed.mif -act $subj/5tt_anat.mif -backtrack -crop_at_gmwmi $subj/wmfod_norm.mif $subj/act_wbt.tck
	done