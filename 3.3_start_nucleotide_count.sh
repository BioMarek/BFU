#!/bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz filtered sequences with proper length and high quality
## SCRIPT OUTPUT *.txt file counts with length distribution and starting nucleotide distribution
# The script counts length distribution and starting nucleotide distribution of sequences so we can make histogram

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/filtered # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/start_counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $DATASET_DIR

#for file in *mirna.fastq.gz
#do
#  gunzip -c $file  | sed -n 'n;p;n;n;' > temp
  
#done

gunzip -c H11_A_ATCACG_mirna.fastq.gz  | sed -n 'n;p;n;n;' > temp

while read line
do
  awk '{print length}' $line >> temp2
done < temp
