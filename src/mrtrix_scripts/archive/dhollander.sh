#dwi response estimation in mrtrix using dhollandar method (for multi-shell, multi-tissue CSD)
#Ref. T. Dhollander, D. Raffelt, and A. Connelly. Accuracy of response function estimation algorithms for 3-tissue spherical deconvolution of diverse quality diffusion MRI data. 
#Proceedings of the 26th annual meeting of the International Society of Magnetic Resonance in Medicine (2018), pp. 1569. 
#script by Meaghan Perdue April 2019

#cd /Volumes/EEG/a214/

for subj in $(cat subjlist2.txt)
	do
	dwi2response dhollander -voxels $subj/voxels.mif $subj/dwi_preproc_biascorr.mif $subj/wm_response.txt $subj/gm_response.txt $subj/csf_response.txt
	done

#check output: shview wm_response.txt
#use L-R arrow keys to move through b-values, b0 should be spherical, higher b-vals should get more pancake-like