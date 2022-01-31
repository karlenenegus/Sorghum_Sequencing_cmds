#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/1_data_0
#SBATCH -o ./outputs/1_data.o%j
#SBATCH -e ./outputs/1_data.e%j
#SBATCH --ntasks=4
#SBATCH --cores=6
#SBATCH --mem=128G
ulimit -s unlimited
module load python
module load py-cutadapt
module load trimgalore
module load parallel
cd ../1_data
parallel --xapply trim_galore --paired --fastqc --trim1 -o trimgalore/ ::: *R1_001.fastq ::: *R2_001.fastq
scontrol show job $SLURM_JOB_ID

