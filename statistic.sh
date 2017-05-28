#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  
## SCRIPT OUTPUT 
# The script trims adapter sequences using cutadapt from raw sequencing data

#######################################################################################################################
##SPECIFY DATA VARIABLES##
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/raw_sequences # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/statistic

#######################################################################################################################
###SCRIPT BODY###
mkdir -p $OUTPUT_DIR
cd $DATASET_DIR

for file in *.fastq.gz
do
  gunzip -c $file | sed -n 'n;p;n;n;' > temp
  echo 'number of raw sequences: ' `wc -l temp` '\t' >> ${file:0:5}_statistic.txt
done
echo '\n' >> ${file:0:5}_statistic.txt
