#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/5_freebayes_0
#SBATCH -o ./outputs/5_freebayes.o%j
#SBATCH -e ./outputs/5_freebayes.e%j
module load python
ulimit -s unlimited
cd ../5_freebayes
for bam in ../4_processing/*-md-rg.bam*; do
  ln -s $bam;
done
echo "sh ../cmds/runFreeBayes.sh" > freebayes.cmds
python ../cmds/makeSLURMs.py 1 freebayes.cmds
sbatch freebayes_0.sub
scontrol show job $SLURM_JOB_ID