#!/bin/bash
#
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/trimmed # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/counts # path to output sequences

mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *trimmed.fastq
do
   # sed leaves sequences from fastq file and removes everything else
   # awk prints length of sequences
   # uniq counts sequences a writes how many times each one was there
   # sort sorts numericaly based on second column
   sed -n 'n;p;n;n;' $file | awk '{print length}' $file | sort | uniq -c | sort -n -k 2 > ${file:0:12}_counts.txt
   mv ${file:0:12}_counts.txt $OUTPUT_DIR
done

