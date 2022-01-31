#!/bin/bash
#SBATCH -N 1
#SBATCH -n 36
#SBATCH -t 96:00:00
#SBATCH -J ./outputs/4_processing_0
#SBATCH -o ./outputs/4_processing.o%j
#SBATCH -e ./outputs/4_processing.e%j
module load python
ulimit -s unlimited
cd ../4_processing
for bam in ../3_mapping/*.bam; do
  ln -s $bam;
done
mkdir temp
while read a b; do
  echo "sh ../cmds/runProcessing.sh ${a}.bam ${b}";
done < ../cmds/names.txt >process.cmds
python ../cmds/makeSLURMs.py 1 process.cmds
for sub in *.sub; do
  sbatch $sub;
done
scontrol show job $SLURM_JOB_ID