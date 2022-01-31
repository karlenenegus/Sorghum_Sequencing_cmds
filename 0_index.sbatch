#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/0_index_0
#SBATCH -o ./outputs/0_index.o%j
#SBATCH -e ./outputs/0_index.e%j
#SBATCH --wait
ulimit -s unlimited
module load bwa
cd ../0_index
bwa index GCF_000003195.3_Sorghum_bicolor_NCBIv3_genomic.fasta
scontrol show job $SLURM_JOB_ID