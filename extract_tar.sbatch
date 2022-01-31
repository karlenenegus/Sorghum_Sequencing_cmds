#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J extract_tar_0
#SBATCH -o extract_tar.o%j
#SBATCH -e extract_tar.e%j
ulimit -s unlimited
tar -xf 2_43141_01_Tx2910_H5NHK_2044.tar
scontrol show job $SLURM_JOB_ID