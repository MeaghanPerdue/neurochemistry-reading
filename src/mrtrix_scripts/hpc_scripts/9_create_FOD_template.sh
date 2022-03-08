#!/bin/bash
#create study-specific FOD template
#this is one of the most time-consuming steps, set slurm job time to ~24 hours and use 16 threads


cd /mrtrix_out

population_template template/fod_input -mask_dir template/mask_input template/wmfod_template.mif -voxel_size 1.25 -debug -nthreads 16
