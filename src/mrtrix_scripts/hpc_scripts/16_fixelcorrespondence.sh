#!/bin/bash
#match subject fixels to template fixels
#saves output to a single fixel directory for all subjects to accommodate later group FBA
#must run sequentially! don't loop to create separate jobs for each subject, this script will loop itself within the container
#run as sbatch run_container_mrtrix.sh ./16_fixelcorrespondence.sh 
#script by Meaghan Perdue, June 2020


#mrtrix_out=/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix

for i in $(cat subjlist.txt); do
	cd /mrtrix_out/${i}
	fixelcorrespondence fixel_in_template_space/fd.mif ../template/fixel_mask ../template/fd ${i}.mif -nthreads 4 -debug
	done


