#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/2_fastqc_0
#SBATCH -o ./outputs/2_fastqc.o%j
#SBATCH -e ./outputs/2_fastqc.e%j
ulimit -s unlimited
module load fastqc
cd ../2_fastqc
for fq in ../1_data/*.fastq; do
  ln -s $fq
done
fastqc *.fastq
scontrol job $SLURM_JOB_ID