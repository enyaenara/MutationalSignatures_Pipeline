#!/bin/bash

#Desarrollar las instrucciones para bwa

#Designar variables para los 4 archivos de salida de trimmomatic

FP=$1
RP=$2
FU=$3
RU=$4

#Asignar la variable del genoma de referencia
GENREF='../../Referencias/Homo_sapiens_assembly38.fasta'
#Asignar la ruta de BWA
BWA='../../Programas/bwa-0.7.17/bwa/bwa mem -t 8'
#Asignar ruta de salida
BAMs='../Intermediate-Files/BAMs/'
BAMsDup='../Intermediate-Files/DedupsBAMs/'
#Asignar la variable para el archivo de salida de bwa
SAMP=$(basename ${FP}|sed 's/_1_paired.fastq.gz/_paired.sam/')
SAMF=$(basename ${FP}|sed 's/_paired.fastq.gz/_single.sam/')
SAMR=$(basename ${RP}|sed 's/_paired.fastq.gz/_single.sam/')

#Realizar anotación

echo Voy a realizar la anotacion de FP y RP
${BWA} ${GENREF} ${FP} ${RP} -o ${BAMs}${SAMP}  
echo Voy a realizar la anotacion del FU
${BWA} ${GENREF} ${FU} -o ${BAMs}${SAMF}
echo Voy a realizar la anotacion del RU
${BWA} ${GENREF} ${RU} -o ${BAMs}${SAMR}
echo Ya termine la anotacion 

####Pasar archivos de SAM a BAM

#Asignar variables para el cambio de extension en SAMtools
BAMP=$(echo ${SAMP} |sed 's/\.sam/\.bam/')
BAMF=$(echo ${SAMF} |sed 's/\.sam/\.bam/')
BAMR=$(echo ${SAMR} |sed 's/\.sam/\.bam/')

#Asignar variable de la ruta SAMtools
SAM="../../Programas/samtools-1.12/samtools"

#Cambio de formato de SAM a BAM 
${SAM} view -bS --threads 8 ${BAMs}${SAMP} -o ${BAMs}${BAMP}
${SAM} view -bS --threads 8 ${BAMs}${SAMF} -o ${BAMs}${BAMF}
${SAM} view -bS --threads 8 ${BAMs}${SAMR} -o ${BAMs}${BAMR}

###Realizar ordenamiento de las lecturas

#Asignar ruta para Picard
Picard="java -jar ../../Programas/picard/build/libs/picard.jar"
#Cambio de nombre para generar archivos BAM sorted
BAMsortP=$(echo ${BAMP} |sed 's/\.bam/_sorted\.bam/')
BAMsortF=$(echo ${BAMF} |sed 's/\.bam/_sorted\.bam/')
BAMsortR=$(echo ${BAMR} |sed 's/\.bam/_sorted\.bam/')
#Realizar ordenamiento con Picard 
${Picard} SortSam -I ${BAMs}${BAMP} -O ${BAMs}${BAMsortP} -SO coordinate
${Picard} SortSam -I ${BAMs}${BAMF} -O ${BAMs}${BAMsortF} -SO coordinate
${Picard} SortSam -I ${BAMs}${BAMR} -O ${BAMs}${BAMsortR} -SO coordinate

#Cambio de nombre para el archivo BAM merged
BAMmerged=$(echo ${BAMsortP} | sed 's/_paired_sorted\.bam/_merged\.bam/')
#Realizar merged con Picard
${Picard} MergeSamFiles -I ${BAMs}${BAMsortP} -I ${BAMs}${BAMsortR} -I ${BAMs}${BAMsortF} -O ${BAMs}${BAMmerged}

#Asignar nombre al archivo de salida
BAMmergedRG=$(echo ${BAMmerged} |sed 's/_merged\.bam/_merged_RG\.bam/')
#Asignar variables de readgrpups
base=$(basename ${FP} |sed 's/_1_paired.fastq.gz//')
RGID="${base}"
RGLB="lib1"
RGPL="ILLUMINA"
RGPU="${base}_unit"
RGSM="${base}_sample"

${Picard} AddOrReplaceReadGroups -I ${BAMs}${BAMmerged} -O ${BAMs}${BAMmergedRG} -LB ${RGLB} -PL ${RGPL} -PU ${RGPU} -SM ${RGSM} -ID ${RGID} --CREATE_INDEX true


#Asignar nombre para el archivo final con duplicados marcados
BAMdedup=$(echo ${BAMmergedRG} | sed 's/_merged_RG\.bam/_dedup\.bam/')

#Archivo de métricas de duplicados
METRICS=$(echo ${BAMdedup} | sed 's/_dedup\.bam/_metrics\.txt/')

#Marcar duplicados con Picard
${Picard} MarkDuplicates \
    -I ${BAMs}${BAMmergedRG} \
    -O ${BAMsDup}${BAMdedup} \
    -M ${BAMs}${METRICS} \
    --REMOVE_DUPLICATES false \
    --CREATE_INDEX true

