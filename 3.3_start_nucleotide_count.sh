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

cp * $SCRATCH

for file in *mirna.fastq.gz
do
  cd $SCRATCH
  # creates directory for each file
  mkdir ${file:0:5}
  gunzip -c $file  | sed -n 'n;p;n;n;' > ${file:0:5}/temp
  cd ${file:0:5}
  while read line
  do
    # takes a lines and redirects them into files based on length
    # echo ${#line} measures the lenght of line
    echo $line >> `echo ${#line}`
  done < temp
  rm temp
done

mv * $OUTPUT_DIR
rm -rf *
