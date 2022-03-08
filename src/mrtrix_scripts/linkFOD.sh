 for subj in $(cat subjlist2.txt)
 	do
 	cp -RivL $subj/wmfod_norm.mif template/fod_input/$subj_norm.mif
 	cp -RivL $subj/dwi_mask_upsampled.mif template/mask_input/$subj_mask.mif
done


