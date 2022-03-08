#create mask for seeding on GM-WM interface, run before tckgen
#script by Meaghan Perdue, April 2020

for subj in $(cat subjlist2.txt)
	do
	5tt2gmwmi $subj/5tt_anat.mif $subj/5ttgmwmi.mif
	done