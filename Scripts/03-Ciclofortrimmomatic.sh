for archivo in $(ls ../Input-Files/FASTQs/SRR*|cut -d '_' -f 1|uniq)
do ./02-Trimmomatic.sh ${archivo}'_1.fastq.gz' ${archivo}'_2.fastq.gz'
done
