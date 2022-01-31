#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/3_mapping_0
#SBATCH -o ./outputs/3_mapping.o%j
#SBATCH -e ./outputs/3_mapping.e%j
#SBATCH --mem=128G
module load python
ulimit -s unlimited
cd ../3_mapping
for fq in ../1_data/trimgalore/*.fq; do
  ln -s $fq
done
for r1 in *R1_001_val_1.fq; do
  r2=$(echo $r1 |sed 's/*R1_001_val_1.fq/*R2_001_val_2.fq/g')
  genome="../0_index/GCF_000003195.3_Sorghum_bicolor_NCBIv3_genomic.fasta"
  echo "sh ../cmds/runBWA.sh $genome $r1 $r2" ;
done > bwa.cmds
python ../cmds/makeSLURMs.py 1 bwa.cmds
for sub in *.sub; do
  sbatch $sub;
done
scontrol show job $SLURM_JOB_ID
