#compute fiber cross-section metric and combined fiber density and cross-section metric
#script by Meaghan Perdue, April 2019
#cd /Volumes/EEG/a214/

for subj in $(cat subjlist2.txt)
	do
	warp2metric -force $subj/subject2template_warp.mif -fc template/fixel_mask_18 template/fc $subj.mif
	done	
mkdir template/log_fc
cp template/fc/index.mif template/fc/directions.mif template/log_fc

for subj in $(cat subjlist2.txt)
	do
	mrcalc -force template/fc/$subj.mif -log template/log_fc/$subj.mif
	done

mkdir template/fdc
cp template/fc/index.mif template/fdc
cp template/fc/directions.mif template/fdc
for subj in $(cat subjlist2.txt)
	do
	mrcalc -force template/fd/$subj.mif template/fc/$subj.mif -mult template/fdc/$subj.mif
	done