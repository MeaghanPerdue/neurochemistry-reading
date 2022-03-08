#run whole brain tractography on template using 2000000 streamlines (better to use 20 mil, just saving time here)

cd template
#tckgen -angle 22.5 -maxlen 250 -minlen 10 -power 1.0 wmfod_template.mif -seed_image template_mask.mif -mask template_mask.mif -select 2000000 -cutoff 0.06 tracks_2_million.tck
tckgen -angle 22.5 -maxlen 250 -minlen 10 -power 1.0 wmfod_template.mif -seed_image template_mask.mif -mask template_mask.mif -select 100000 -cutoff 0.06 tracks_100k.tck