for subj in $(cat subjlist2.txt)
do
	dwibiascorrect -ants $subj/dwi/dwi_preprocessed.mif $subj/dwi_preproc_biascorr.mif
	dwi2mask $subj/dwi_preproc_biascorr.mif $subj/mask.mif
done
