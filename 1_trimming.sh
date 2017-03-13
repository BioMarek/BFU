#!/bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz with raw sequences from sequencing
## SCRIPT OUTPUT *.fastq.gz sequences without adapter
# The script trims adapter sequences using cutadapt from raw sequencing data

#######################################################################################################################
##SPECIFY DATA VARIABLES##
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/raw_sequences # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/trimmed # path to output sequences
ADAPTER="TGGAATTCTCGGGTGCCAAGG" # adapter sequence to be trimmed (illumina adapter RNA 3’ Adapter (RA3))

#######################################################################################################################
###SCRIPT BODY###
module add python27-modules-gcc
module add python27-modules-intel

cd $DATASET_DIR

for file in *.fastq.gz
do
  cp $file $SCRATCH
done

cd $SCRATCH
mkdir $OUTPUT_DIR

for file in *.fastq.gz
do
  # cuts adapter and tosses everything shorter than 1 base
  cutadapt -a $ADAPTER -m 1 -o ${file:0:12}_trimmed.fastq.gz $file
  # when working in $SCRATCH I do calculation first and then move files with results in order to take advantage of SSDs
  mv ${file:0:12}_trimmed.fastq.gz $OUTPUT_DIR
done

rm -rf *
