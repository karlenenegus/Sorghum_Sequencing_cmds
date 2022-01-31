# Variant Discovery Workflow

These files were adapted from the FreeBayes cariant calling workflow found at https://bioinformaticsworkbook.org/dataAnalysis/VariantCalling/variant-calling-index#gsc.tab=0

# Directory Structure 

Run to create appropriate directory structure 

	mkdir -p 0_index 1_data/trimgalore 2_fastqc 3_mapping 4_processing/temp 5_freebayes 6_filtering cmds/ouputs 

# INFO 

Some info should be changed to match naming for a specific project

### 0_index.sbatch
check reference fasta name
modules: bwa 
### 1_data.sbatch
check pair end files extensions are correct (i.e. do files end in *R1_001.fastq & *R2_001.fastq)
modules: parallel; py-cutadapt; trimgalore; trimgalore
### 2_fastqc.sbatch
check fastq files match listed directory location
modules: fastqc
### 3_mapping.sbatch
check: reference fasta name; pair end files extensions are correct; fastq files match listed directory location
local script dependencies: runBWA.sh; makeSLURMS.py
* runBWA.sh
check: pair end files extensions are correct
modules: bwa; samtools
* makeSLURMs.py		
### 4_processing.sbatch
local script dependencies: runProcessing.sh; names.txt; makeSLURMs.py
* runProcessing.sh
### 5_freebayes.sbatch
	
### 6_filtering.sbatch
modules: vcftools

