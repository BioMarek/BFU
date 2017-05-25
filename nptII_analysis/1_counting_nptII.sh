#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fasta reads mapped to nptII gene from geneious
## SCRIPT OUTPUT *.txt files with length counts

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/nptII/mapped_reads # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/nptII/counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir -p $OUTPUT_DIR
cd $DATASET_DIR

for file in *.fasta
do
   # leaves sequences from fasta file, removes everything else, awk prints lengths of sequencs; uniq counts the sequences.
   sed -n 'n;p;' $file | awk '{print length}' | sort | uniq -c > $OUTPUT_DIR/${file:0:3}_counts.txt
   # chmod sets access right so that only owner can work with file
   chmod 700 $OUTPUT_DIR/${file:0:3}_counts.txt
done
