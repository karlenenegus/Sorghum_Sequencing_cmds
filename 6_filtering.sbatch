#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/6_filtering_0
#SBATCH -o ./outputs/6_filtering.o%j
#SBATCH -e ./outputs/6_filtering.e%j
ulimit -s unlimited
module load vcftools
cd ../6_filtering
ln -s ../5_freebayes/output.vcf
vcf=output.vcf
vcftools --vcf $vcf --keep-only-indels --recode --recode-INFO-all --out output_indels-only.vcf
vcftools --vcf $vcf --remove-indels --recode --recode-INFO-all --out output_snps-only.vcf
scontrol show job $SLURM_JOB_ID