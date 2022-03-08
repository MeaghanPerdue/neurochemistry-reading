#seed-based tractography using probabilistic ACT
#script by Meaghan Perdue, April 2020

for subj in $(cat subjlist2.txt)
	do
	tckgen -algorithm iFOD2 -select 100 -seed_image $subj/VOI_mask/mask_t1.nii.gz $subj/wmfod_norm.mif $subj/STG.tck
	done