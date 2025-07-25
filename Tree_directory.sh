#! /bin/bash

#Script para generar las carpetas para todos los archivos
#Corre este Script en la carpeta principal de tu proyecto

mkdir -p Input-Files/BEDs Input-Files/FASTQs
mkdir -p Intermediate-Files/Filtered-FASTQs Intermediate-Files/BAMs Intermediate-Files/DedupsBAMs Intermediate-Files/Recalibration Intermediate-Files/FASTQC/Before_T Intermediate-Files/FASTQC/After_T
mkdir -p Results/TSV Results/VCFs/VCF_tar Results/VCFs/VCF_unfiltered Results/VCFs/VCF_filtered Results/VCFs/VCF_table Results/VCFs/VCF_pass
mkdir -p Scripts
