#!/bin/bash
#Entrada de archivos fastq forward y reverse 
F=$1
R=$2

#Renombrar archivos de salida
FP=$(basename ${F}|sed 's/.fastq/_paired.fastq/')
FU=$(basename ${F}|sed 's/.fastq/_unpaired.fastq/')
RP=$(basename ${R}|sed 's/.fastq/_paired.fastq/')
RU=$(basename ${R}|sed 's/.fastq/_unpaired.fastq/')

#Asignar la carpeta de salida
FILTERFQ='../Intermediate-Files/Filtered-FASTQs/'

#Asignar ruta de trimmomatic
trimmomatic='java -jar /mnt/d/Programas/Trimmomatic-0.39/trimmomatic-0.39.jar PE'

ILLUMINA='/mnt/d/Programas/Trimmomatic-0.39/adapters/TruSeq3-PE.fa'

#Correr el trimmomatic
echo Estoy usando Trimmomatic para limpiar mis muestras
${trimmomatic} ${F} ${R} ${FILTERFQ}${FP} ${FILTERFQ}${FU} ${FILTERFQ}${RP} ${FILTERFQ}${RU} ILLUMINACLIP:${ILLUMINA}:2:30:10 SLIDINGWINDOW:4:25 HEADCROP:10 MINLEN:70
echo Ya termine de usar Trimmomatic

