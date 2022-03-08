#!/bin/bash
#SBATCH --partition=general
#SBATCH --ntasks=1				      # Request 8 CPU cores
#SBATCH --nodes=1                     # OpenMP requires all tasks running on one node
#SBATCH --time=01:00:00			      # Job should run up to 12 hours
#SBATCH --mail-type=END			      # Trigger email notification
#SBATCH --mail-user=meaghan.perdue@uconn.edu  #destination email address

module load singularity/3.5.2
module load squashfs
export SINGULARITY_CACHEDIR=/scratch/$USER
export SINGULARITY_TMPDIR=/scratch/$USER

singularity build MRtrix3.sif docker://sclove/mrtrix3.0.2

