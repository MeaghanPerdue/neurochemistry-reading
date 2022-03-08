for subj in $(cat subjlist.txt)
   do
   mv $subj/mask.mif $subj/dwi/mask.mif
done

