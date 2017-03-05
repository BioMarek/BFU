#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz filtered sequences with proper length and high quality
## SCRIPT OUTPUT *.zip file containing results from FastQC analysis
# The script performs quality analysis using FastQC on sequencing data

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/filtered # path to input sequences
OUTPUT_DIR=$PROJECT_DIR/fastqc_after_filt # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *mirna.fastq.gz
do
   cp $file $SCRATCH
done

cd $SCRATCH
module add fastQC-0.10.1

# STDIN for FastQC doesn't so work we have to decompress files
for file in *mirna.fastq.gz
do
   gzip -d $file 
done

for file in *mirna.fastq
do
   fastqc $file
done

mv *.zip $OUTPUT_DIR
rm -rf *
