for subj in $(cat subjlist.txt)
	do
	mkdir $subj
	cp /Volumes/EEG/a214/archive/$subj/dwi/*.nii.gz $subj
	cp /Volumes/EEG/a214/archive/$subj/dwi/*.json $subj
	cp /Volumes/EEG/a214/archive/$subj/dwi/*.bvec $subj
	cp /Volumes/EEG/a214/archive/$subj/dwi/*.bval $subj
	cp -RivL /Volumes/a214/bids/sub-$subj/ses-01/fmap $subj
done

