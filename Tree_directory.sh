#! /bin/bash

#Script para generar las carpetas para todos los archivos
#Corre este Script en la carpeta principal de tu proyecto


mkdir -p Raw_Data/BED_files Raw_Data/Fastq_files
mkdir -p Intermediate_files/BAM_files Intermediate_files/DuBAM_files Intermediate_files/FastQC/Before_T Intermediate_files/FastQC/After_T Intermediate_files/Filtered_Fastq Intermediate_files/gVCFs
mkdir -p Results/TSV Results/VCFs Results/VCFs_bysample Results/VEP_bysample
mkdir -p Scripts
