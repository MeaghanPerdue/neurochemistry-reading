for subj in $(cat subjlist_all.txt)
	do
	cp /Volumes/a214/bids/sub-$subj/ses-01/anat/*.nii.gz $subj
done
