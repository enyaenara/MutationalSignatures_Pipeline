#!/bin/bash

for MUESTRA in $(ls ../Intermediate-Files/Filtered-FASTQs/SRR*|cut -d '_' -f 1|uniq)
do ./05-BWA.sh $MUESTRA'_1_paired.fastq.gz' $MUESTRA'_2_paired.fastq.gz' $MUESTRA'_1_unpaired.fastq.gz' $MUESTRA'_2_unpaired.fastq.gz'
done
