# Variant Discovery Workflow

These files were adapted from the FreeBayes cariant calling workflow found [here](https://bioinformaticsworkbook.org/dataAnalysis/VariantCalling/variant-calling-index#gsc.tab=0).

All files are written for use with paired end reads. Resource allocation should be reevaluated throughout to improve speed of jobs.

## Directory Structure

Run the following to create appropriate directory structure

	mkdir -p 0_index 1_data/trimgalore 2_fastqc 3_mapping 4_processing/temp 5_freebayes 6_filtering cmds/ouputs

Files will need to be placed in some directories
* 0_index: reference genome fasta file
* 1_data: sequencing fastq files or fastq.gz (in the case of .gz extension be sure to appropriately change all subsequent references to the files)

## SLURM basics
To run .sbatch files use the sbatch SLURM command. For example

    sbatch 0_index.sbatch

Progress of a submitted jobs can easily be checked using

    squeue --me

Cancel a job using

    scancel <jobID>

## File Info

Some info may need to be changed to match a specific project. Pay specific attention to 'check file names' sections which may cause issues when starting a new project. Files with the '.sbatch' extension should be run in sequentially in numerical order. In most cases the preceding .sbatch file needs to be completed before running the subsequent one. The exception would be 2_fastqc.sbatch which does not need to be completed if trimming is completed as currently written in 1_data.sbatch. It would be a good idea to check whether trimming is necessary using the 2_fastqc.sbatch as a stand alone process before going ahead.

#### 0_index.sbatch
Check file names
* reference fasta

Modules
* bwa

#### 1_data.sbatch
Check file names
* pair end files extensions (currently works for files ending in \*R1_001.fastq & \*R2_001.fastq)

Modules
* python
* parallel
* py-cutadapt
* trimgalore

#### 2_fastqc.sbatch
Check file names
* fastq file extension (currently listed as \*.fastq)

Modules
* fastqc

#### 3_mapping.sbatch
Check file names
* reference fasta name (current: GCF_000003195.3_Sorghum_bicolor_NCBIv3_genomic.fasta)
* pair end files extensions (\*R1_001_val_1.fq & \*R2_001_val_2.fq)

Fastq files will be coming from the ../1_data/trimgalore/ directory location. Please verify that is appropriate.

Script dependencies (these files must be located in the ../cmds folder for 3_mapping.sbatch to work correctly)
* runBWA.sh
* makeSLURMS.py

#### runBWA.sh
Check file names
* pair end files extensions (current: _R1_001_val_1.fq)

modules
* bwa
* samtools

#### makeSLURMS.py

This file was copied from [here](https://github.com/ISUgenomics/common_scripts/blob/master/makeSLURMs.py)

It may be relevent to edit the following section within the file

    w.write("#SBATCH -n 36\n")
    w.write("#SBATCH -t 96:00:00\n")
    w.write("#SBATCH --mem=128G\n")

-n : number of nodes

-t : time the job will be allowed to complete within

--mem : the amount of memory allocated to the job

Other relevant options can be added to the same section using a matching format. For more details go to this [link](https://researchit.las.iastate.edu/slurm-basics).

#### 4_processing.sbatch
Modules
* python

Script dependencies
* runProcessing.sh
* names.txt
* makeSLURMs.py

*names.txt will need to be edited before this job will run.*

#### runProcessing.sh

Modules
* picard
* samtools

#### names.txt

This file must be changed to match naming both for upstream and downstream files.

The first column of the tab-delimitated text file should match the .bam file prefixes which result from 3_mapping.

The second column should be the names which you would like included as the individuals names in the VCF file which results from 5_freebayes

#### 5_freebayes.sbatch
This will take a while to run. It may complete faster if ran on the 'speedy' server. Instruction to do so have not been included yet.

Modules
* python

Script dependencies
* runFreeBayes.sh
* makeSLURMS.py

#### runFreeBayes.sh
Check file names
* reference fasta name (current: GCF_000003195.3_Sorghum_bicolor_NCBIv3_genomic.fasta)

Modules
* freebayes

#### 6_filtering.sbatch
Modules
* vcftools
