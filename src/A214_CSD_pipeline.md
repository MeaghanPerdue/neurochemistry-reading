# Constrained Spherical Deconvolution Pipeline for A214 via MRTrix3
## running MRTrix3 v 3.0.2 via container on UConn HPC

## Resources:
MRtrix3 documentation: [https://mrtrix.readthedocs.io/en/latest/](https://mrtrix.readthedocs.io/en/latest/)

slides from 2018 MRtrix3 workshop: [https://osf.io/zkumq/?view_only=07886dbcf51448e6ba01592790e77c3d](https://osf.io/zkumq/?view_only=07886dbcf51448e6ba01592790e77c3d)

## Preparing environment:
### HPC
mrtrix container: [https://hub.docker.com/r/sclove/mrtrix3.0.2](https://hub.docker.com/r/sclove/mrtrix3.0.2)
Has mrtrix 3.0.2, FSL 6.0.4 & ANTS 2.3.4

*To pass subject IDs to container, use singularity exec (not singularity run)

scripts located in LandiLab R-drive:
Projects/A214_MRI/mrtrix_scripts/hpc_scripts

these need to be copied to HPC scratch directory to run

pull container: 

hpc_scripts/sbatch_build_container.sh

create a folder in your scratch directory called a214_data

copy bids-formatted data to scratch/YOURNETID/a214_data

create sub-folders: 

scratch/YOURNETID/a214_data/derivatives/mrtrix will be the output folder for processed data

copy scripts from PSYCH_Landi/Projects/A214_MRI/src/mrtrix_scripts/hpc_scripts to your scratch directory

add rwx permissions to all your scripts using chmod 777 *.sh (this can be run from the scratch dir login node)

some scripts use multithreading, indicated by the -nthreads option. before running the script, make sure that the # of cpus-per-task and OMP_NUM_THREADS and ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS options in run_container_mrtrix.sh are set to match the # of threads in the script

Upload outputs for already-processed subjects from MP's dissertation to the scratch/YOURNETID/a214_data/derivatives/mrtrix folder: should be fine to just copy the whole output folder from the R-drive back to the HPC: Projects/A214_MRI/a214_data/derivatives/mrtrix

Just omit the "archive" and "desktop_preproc" sub-folders to save space on HPC

### Local computer
Install mrtrix3.0.2: https://mrtrix.readthedocs.io/en/0.3.14/installation/mac_install.html

Install FSL 6.0.4: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/MacOsX

Meaghan's old computer (Shallan) had both of these installed as of spring 2021, so they should work for all users as long as that computer hasn't been wiped.

If you want to copy things back and forth between local machine and HCP via the command line (rather than Globus), you'll need to generate an RSA key pair on your local machine:

 > ssh-keygen -t rsa

you can set the passphrase if you wish, or just hit return for no passphrase (I recommend no passphrase)

Copy key from local machine to HPC:

>  ssh-copy-id -i ~/.ssh/id_rsa.pub YOURNETID@login.storrs.hpc.uconn.edu
  
Now when you log into the HPC in a new terminal, it should connect using the RSA key instead of prompting your password

Copy between local computer and HPC using scp command (secure copy). Run from terminal on local machine (not logged into HPC):

> #from HPC to local machine
>  
>  scp abc12345@login.storrs.hpc.uconn.edu:/home/abc12345/test.sh $HOME/Desktop
>  
>  #from local machine to HPC
>  
>  scp $HOME/Desktop/test.sh abc12345@login.storrs.hpc.uconn.edu:/home/abc12345
>  
>  #copying a folder and its contents
>  
>  scp -r -p $HOME/Desktop/test abc12345@login.storrs.hpc.uconn.edu:/home/abc12345

## How to run scripts in mrtrix container
data must be in BIDS format

see comments within scripts for setup and toubleshooting notes

### To run a single subject:

> sbatch run_container_mrtrix.sh ./1b_dwi_prep_all_bids_3run_hpc.sh sub-214999

*change the 1b_dwi_prep_all_bids_3run_hpc.sh to whichever script you want to run, change subject ID* 

### To submit jobs for a batch of subjects, create a script to loop over subjects for job submission

see submit_jobs_batch_example.sh in hcp_scripts

*unless otherwise noted, run all scripts below using the container*

## Phase 1: Preprocessing
### 1. run mrtrix/FSL preproc: denoising, degibbs, topup, eddy via HPC: 

> hpc_scripts/1b_dwi_prep_all_bids_3run_hpc.sh 

Script assumes subject has completed 3 runs of DWI
	
copy outputs back to R-drive for visual inspection of res.mif and degibbs outputs 
(script for copying: cpfromHPC.sh in the R-drive A214_MRI/a214-data/derivatives/mrtrix folder, update to copy subjects needed, OR use Globus)

Visual QC on local computer:

following this step, do QC by visually inspecting residuals for lack of anatomy (see MRtrix_visual_QC_steps.docx):

navigate into subject's output folder in R drive A214_MRI/a214-data/derivatives/mrtrix/preproc/sub-#####

> mrview dwi_raw.mif res.mif dwi_degibbs.mif

### 2. run eddy_quad on local machine (doesn't work in container)  

> 2b_eddy_qc_3run.sh

using MATLAB, run 2c_Json_to_csv_output_for_diffusionQC.m to extract QC parameters from subjects' eddyqc outputs to a csv file (the matlab script is for 2018a, may need to change for later versions)

using python, use 2d_eddy_quad_merge.py to evaluate pass/fail and merge eddyqc output with dwi data tracking spreadsheet

Review spreadsheet for eddyqc pass/fail, no further processing for subjects who failed at this step


### 3. DO NOT run bias correction 
(in this step it's just for better mask estimation, but actually resulted in worse masks in our sample)

## Phase 2: Constrained Spherical Deconvolution (CSD)

### 4. run response estimation, upsampling, and brainmask creation using BET  

**up to this step can be done for each subj. separately**

> 4_dwi2resp_upsample_betmask.sh

after this step, copy data from HPC and visually inspect dwi_preproc_upsampled_bet_mask.nii.gz, make edits if needed, best to have a conservative mask for subsequent step  
(see MRtrix_visual_QC_steps.docx)

### 5. run group avg response function -> create group average used for subsequent processing 
**DO NOT RUN THIS STEP**

ok to use a sub-set of 30-40 subjects for this per mrtrix documentation, so no need to re-run with new subjects, just use the output from MP's dissertation run, copy group average response files to HPC: 

> scp -r -p /Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/group_average_response_*.txt NETID@login.storrs.hpc.uconn.edu:/scratch/NETID/a214_data/derivatives/mrtrix

or use Globus

### 6. run fiber orientation distribution estimation: multi-shell, multi-tissue CSD - use bet brainmask

> 6_dwi2fod.sh

### 7. run mtnormalise bias-correction and normalization of fods (this is instead of dwi_normalise group) - use conservative brain mask!

> 7_mtnormalise.sh

## Phase 3: Prep data for FBA
Run Phase 3 once all subjects to be included in the analysis have been processed through prior steps. 

### 8. create template directory and link subject FOD and mask image
**DO NOT RUN THIS STEP** - template was created with N=37 subjects for MP dissertation and does not need to be repeated with the full sample

> 8_prep_template_folder.sh 

do this outside the container, just in the command line in the login node should be fine

### 9. create a study-specific unbiased FOD template 
**DO NOT RUN THIS STEP** - template was created with N=37 subjects for MP dissertation and does not need to be repeated with the full sample

> 9_create_FOD_template.sh 
run via container

This step took 19 hours 46 mins on the hpc using 16 threads - be sure to adjust slurm job accordingly. If process times out, use -continue option to run from where it left off

### *the template MP made should have been copied from the R-drive to the HPC when you copied the derivatives/mrtrix folder*

Check folder on HPC called scratch/YOURNETID/a214_data/derivatives/mrtrix/template

Make sure the wmfod_template.mif file from here:
A214_MRI/a214_data/derivatives/mrtrix/template/wmfod_template.mif

is in the template folder on the HPC

### 10. register each subject's FOD image to the study-specific template, warp masks to template space 
> 10_mrregister.sh

(takes about 10 mins per subject)


### 11.compute template mask 
> 11_templatemask.sh 	

(1 job for whole group - this one goes quick!)

Visual check template mask to ensure all areas intended to be analyzed are included:

Copy template/template_mask.mif back to local computer and open using:

> mrview template_mask.mif

### 12. compute WM template analysis fixel mask 

>run 12_fod2fixel.sh

(1 job for whole group)

### 13-15. warp subject FODs to template, segment fixels, and reorient to template 

>13-15_warp_seg_reorient.sh  

(<5 mins per subject)


### 16. match each subject's fixels to template fixels & save outputs to a common fixel directory for analysis 

>16_fixelcorrespondence.sh 

run this sequentially, not multiple subjects at once! the script will loop subjects WITHIN the container, so you don't submit multiple jobs

<20 mins to run all subjects

### 17. compute the fiber cross section (FC) metric for each subject 

>17_warp2metric.sh

as for step 16, run this one as a loop within the container (runs super fast!)

### 17b. compute log(FC) values 

>17b_logfc.sh 

this step is recommended to ensure data are centered around 0 and normally distributed

### 18.compute FDC metric for each subject; 

>18_compute_FDC.sh

can be run as single jobs per subject or in a loop, but it's a quick process, so no need to submit multiple jobs

### 19.  whole-brain tractography on the FOD template 

>19_tckgen.sh

this one takes a long time - 3hr 51 mins on HPC w/ 16 threads

### 20. reduce biases in whole-brain tractogram 

>20_tcksift.sh

(took 1hr 6 mins with 16 threads)

### 21. generate fixel-fixel connectivity matrix (

>21_fixelconnectivity.sh 

requires ~32 GB RAM, shouldn't be a problem on the HPC, took ~25 mins with 16 threads)

### 22. smooth fixel data

>22_fixelfilter.sh

### 23. run the Fixel-Based Analysis! 

first create subject list, design matrix, and contrast matrix & upload to HPC under the template directory
subject list (files.txt) must list subjects in the order of the data in the design matrix, and include the .mif file ending
	
design matrix consists of 1 row per subject, with each column representing a variable in the design. A column of 1s is included at left to represent the global intercept
	
contrast matrix cols correspond to the cols in the design matrix, include 0s for global intercept & nuisance vars, 1s for vars of interest for correlation
	
fixelcfestats runs a one-tailed test, so need to run separate tests for pos and neg effects by using 2 rows in the contrast matrix, one with 1 and one with -1
	
Use scripts 23a, 23b, and 23c on the HPC to run a separate job for each metric (same design matrix & contrast matrix can be used for all of them)

### **Done!**

Download everything to the R-drive derivatives/mrtrix folder



