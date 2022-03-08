#!/bin/bash
export mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

for subj in $(cat subjlist_test.txt); do
	cd $mrtrix_out
	dwifslpreproc ${subj}/preproc/dwi_degibbs.mif ${subj}/dwi_preprocessed.mif -rpe_pair -se_epi ${subj}/preproc/b0s.mif -pe_dir ap -align_seepi -eddyqc_all ${subj}/${subj}.qc -force -nthreads 6 -debug 
	dwi2mask -force ${subj}/dwi_preprocessed.mif ${subj}/mask.mif
	done