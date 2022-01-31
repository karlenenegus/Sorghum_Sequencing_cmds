#!/bin/bash
genome=$1
read1=$2
read2=$3
out=$(echo $2 |sed 's/_R1_001_val_1.fq/.bam/g')
module load bwa
module load samtools
bwa mem -M -t 16 $genome $read1 $read2 | samtools sort -o $out -