for MUESTRA in $(ls ../Intermediate-Files/DedupsBAMs/*|cut -d '_' -f 1|uniq)
do ./08-BaseRecalibrator.sh $MUESTRA'_dedup.bam'
done
