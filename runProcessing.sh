#!/bin/bash
bam=$1
name=$2
module load picard
module load samtools
picard SortSam \
      TMP_DIR=./temp \
      I=${bam} \
      O=${bam%.*}-sorted.bam \
      SORT_ORDER=coordinate
picard MarkDuplicates \
      TMP_DIR=./temp \
      I=${bam%.*}-sorted.bam \
      O=${bam%.*}-sorted-md.bam \
      M=${bam%.*}-md-metrics.txt
picard AddOrReplaceReadGroups \
      I=${bam%.*}-sorted-md.bam \
      O=${bam%.*}-sorted-md-rg.bam \
      RGID=${bam%.*} \
      RGLB=${name} \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=${name}
samtools index ${bam%.*}-sorted-md-rg.bam