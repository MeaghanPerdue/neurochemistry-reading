#!/bin/bash
#SBATCH --partition=SkylakePriority	#Name of partition
#SBATCH --account=roh17004
#SBATCH --mail-type=ALL
#SBATCH --mail-user=meaghan.perdue@uconn.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1  #change to ~8 for running dwifslpreproc
#SBATCH -e error_%A_%a.log
#SBATCH -o output_%A_%a.log
#SBATCH --time=01:00:00    #change to 04:00:00 for running dwifslpreproc
#SBATCH --job-name=mrtrix

export OMP_NUM_THREADS=1 			  #<=cpus-per-task - change to ~8 for running dwifslpreproc
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1    #<=cpus-per-task  - change to ~8 for running dwifslpreproc
##### END OF JOB DEFINITION  #####

# singularity settings
module load singularity/3.5.2
img_path=/scratch/mvm16101/MRtrix3.sif  #change to path for your container
export SCRATCH=/scratch/mvm16101  		#change to path for your scratch directory

# run container
singularity exec \
	--bind $SCRATCH/a214_data:/bids_dir \
	--bind $SCRATCH/a214_data/derivatives/mrtrix:/mrtrix_out \
	${img_path} "$@"
	