#!/bin/bash
#

PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/trimmed # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/counts # path to output sequences

mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *trimmed.fastq
do
   # leaves sequences from fastq file, removes everything else and saves result in temporary file
   sed -n 'n;p;n;n;' $file > ${file:0:12}_discarded_fasta.fasta
   
   # awk prints lengths of sequencs; uniq counts the sequences and number of couts; sort sorts numericaly based on second column
   awk '{print length}' ${file:0:12}_discarded_fasta.fasta | sort | uniq -c | sort -n -k 2 > ${file:0:12}_counts.txt
   mv ${file:0:12}_counts.txt $OUTPUT_DIR
   rm ${file:0:12}_discarded_fasta.fasta
done
