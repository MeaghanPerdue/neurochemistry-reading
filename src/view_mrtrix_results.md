# Viewing MRTrix3 results

> cd /Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/template

## load wmfod_template in mrview 

(loads fastest if you create a 3D version of the fodtemplate for viewing)

> mrview wmfod_template_3D.mif

## Open fixel plots

open fixel plots using fixel plot tool from the drop down menu in top RH corner of mrview window  
open tvalue file for contrast of interest  
e.g. fd_stats/index.mif  
select tvalue_t1.mif from the "colour by" drop-down  

in the bottom of the panel, select fwe_1mpvalue_t1.mif in the "threshold by" menu

fixelcfestats runs 1-tailed tests by default: contrast t1 tests positive correlation, contrast t2 tests negative correlation  
set minimum threshold to .975 for p<.05, fwe-corr & corrected for two- 1-tailed tests


## Map fixel results onto tracts:
first reduce # of streamlines:  
> tckedit tracks_2_million_sift.tck -num 200000 tracks 200k_sift.tck

## Map fixel reults to track file (tsf):
> fixel2tsf outputfolder/fwe_pvalue.mif tracks_200k_sift.tck outputfolder/fwe_pvalue.tsf

> fixel2tsf outputfolder/tvalue.mif tracks_200k_sift.tck outputfolder/tvalue.tsf

## view results on tracts rater than fixels:

> mrview wmfod_template_3D.mif

load tracks_200k_sift.tck in tractography tool
color and threshold with .tsf files

