#5 tissue type segmentation using FSL for ACT in mrtrix
#Meaghan Perdue April 2019
#cd /Volumes/EEG/a214/

for subj in $(cat subjlist2.txt)
	do
	5ttgen fsl $subj/*_T1w.nii.gz $subj/5tt_anat.mif
	done

