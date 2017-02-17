# IT'S FUCKED UP! REPAIR IT!!!

#!/bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# The script counts length distribution of sequences so we can make histogram

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/filtered # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *mirna.fastq.gz
do
   # leaves sequences from fastq file, removes everything else and saves result in temporary file
   gunzip -c $file | sed -n 'n;p;n;n;' > ${file:0:12}_discarded_fasta.fasta
   
done

for file in *_discarded_fasta.fasta
do
   # awk prints lengths of sequencs; uniq counts the sequences and number of couts
   awk '{print length}' $file | sort | uniq -c > $OUTPUT_DIR/${file:0:12}_counts.txt
   # chmod sets access right so that only owner can work with file
   chmod 700 $OUTPUT_DIR/${file:0:12}_counts.txt
   rm ${file:0:12}_discarded_fasta.fasta
done
