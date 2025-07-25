#!/bin/bash

#Asignar variables de las rutas
Dedup='../Intermediate-Files/DedupsBAMs/'
Recal='../Intermediate-Files/Recalibration/'
#Variable para el genoma de referencia 
GENREF="../../Referencias/Homo_sapiens_assembly38.fasta"
#Asignar variable al archivo BAM final
BAM=$1 
#Variable de known-sites

MILGENOMAS="../../Referencias/1000G_phase1.snps.high_confidence.hg38.vcf.gz"
MILLS="../../Referencias/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz"

###Recalibración de calidades PHRED con GATK##

#Asignar cambio de nombre para archivo de salida de BaseRecalibrator

BRC=$(basename ${BAM} | sed 's/_dedup\.bam/_recal\.table/')

#Asignar ruta del programa
GATK='java -jar ../../Programas/gatk-4.6.2.0/gatk-package-4.6.2.0-local.jar'

#Ejecutar BaseRecalibrator

echo 'Estoy ejecutando BaseRecalibrator de' ${BAM}

${GATK} BaseRecalibrator -R ${GENREF} -I ${BAM} --known-sites ${MILGENOMAS} --known-sites ${MILLS} -O ${Recal}${BRC}

#Asignar archivo de salida para ApplyBQSR 
ABQSR=$(echo ${BRC} | sed 's/\.table/\.bam/')
#Ajuste con ApplyBQSR 
${GATK} ApplyBQSR -R ${GENREF} -I ${BAM} --bqsr-recal-file ${Recal}${BRC} -O ${Recal}${ABQSR}

BRC2=$(echo ${BRC} | sed 's/_recal\.table/_recal2\.table/')

#Ejecutar BaseRecalibrator por segunda vez

echo 'Estoy ejecutando BaseRecalibrator por segunda vez'

${GATK} BaseRecalibrator -R ${GENREF} -I ${Recal}${ABQSR} --known-sites ${MILGENOMAS} --known-sites ${MILLS} -O ${Recal}${BRC2}

#Asignar archivo de salida para ApplyBQSR
ABQSR2=$(echo ${BRC2} | sed 's/\.table/\.bam/')

#Ajuste con ApplyBQSR
${GATK} ApplyBQSR -R ${GENREF} -I ${Recal}${ABQSR} --bqsr-recal-file ${Recal}${BRC2} -O ${Recal}${ABQSR2}
