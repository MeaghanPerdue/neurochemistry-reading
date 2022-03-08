#!/bin/bash
#for a214. loop over subjects to run mrtrix for each in a different slurm job

for i in $(cat subjlist.txt)
   do
   sbatch run_container_mrtrix.sh ./1b_dwi_prep_all_bids_3run_hpc.sh ${i}
   done
   