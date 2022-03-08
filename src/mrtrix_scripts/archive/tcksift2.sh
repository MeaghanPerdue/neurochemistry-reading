#create mask for seeding on GM-WM interface, run before tckgen
#script by Meaghan Perdue, April 2020

for subj in $(cat subjlist2.txt); do
	tcksift2 -act $subj/5tt_anat.mif $subj/wbt.tck $subj/wmfod_norm.mif $subj/wbt_sift_weights.txt
	done