#run fixel based statistical analysis on fd, log_fc and fdc
#create design_matrix and contrast matrix 
#options available for permutation testing
#cd /Volumes/EEG/a214

fixelcfestats template/fd FBA/subjects.txt FBA/design_matrix.txt FBA/contrast_matrix.txt template/tracks_2_million_sift.tck FBA/stats_fd
fixelcfestats template/log_fc FBA/subjects.txt FBA/design_matrix.txt FBA/contrast_matrix.txt template/tracks_2_million_sift.tck FBA/stats_log_fc
fixelcfestats template/fdc FBA/subjects.txt FBA/design_matrix.txt FBA/contrast_matrix.txt template/tracks_2_million_sift.tck FBA/stats_fdc

#calc effect size percentage for fd
mrcalc FBA/stats_fd/abs_effect.mif FBA/stats_fd/beta0.mif -div 100 -mult FBA/stats_fd/percentage_effect.mif