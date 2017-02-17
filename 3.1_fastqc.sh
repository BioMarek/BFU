#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# The script performs quality analysis using FastQC on sequencing data

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/filtered # path to input sequences
OUTPUT_DIR=$PROJECT_DIR/fastqc_after_trim # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *trimmed.fastq.gz
do
   cp $file $SCRATCH
done

cd $SCRATCH
module add fastQC-0.10.1

for file in *trimmed.fastq
do
   gunzip -c $file | fastqc # test this 
done

cp *.zip $OUTPUT_DIR
rm -rf *
