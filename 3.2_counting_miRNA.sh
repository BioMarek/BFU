#!/bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz filtered sequences with proper length and high quality
## SCRIPT OUTPUT *.txt file counts with length distribution
# The script counts length distribution of sequences so we can make histogram

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/miRNA/filtered # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/miRNA/counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir -p $OUTPUT_DIR
cd $DATASET_DIR

for file in *mirna.fastq.gz
do
   # leaves sequences from fastq file, removes everything else, awk prints lengths of sequencs; uniq counts the sequences.
   gunzip -c $file | sed -n 'n;p;n;n;' | awk '{print length}' | sort | uniq -c > $OUTPUT_DIR/${file:0:12}_counts.txt
   # chmod sets access right so that only owner can work with file
   chmod 700 $OUTPUT_DIR/${file:0:12}_counts.txt
done
