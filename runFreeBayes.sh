#!/bin/bash
ref="../0_index/GCF_000003195.3_Sorghum_bicolor_NCBIv3_genomic.fasta"
module load freebayes
ls *-md-rg.bam > bam.fofn
freebayes \
  --fasta-reference ${ref} \
  --bam-list bam.fofn \
  --vcf output.vcf \