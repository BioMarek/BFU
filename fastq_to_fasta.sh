#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz file
## SCRIPT OUTPUT *.fasta file
# The script converts *.fastq file to *.fasta file so that metacntrum blast can use it

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/reference # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/reference # path to output sequences
INPUT_FILE=file.fq.gz
OUTPUT_FILE=file.fa

#######################################################################################################################
###SCRIPT BODY###
cd $INPUT_DIR

gunzip -c $INPUT_FILE | awk '{if(NR%4==1) {printf(">%s\n",substr($0,2));} else if(NR%4==2) print;}' > $OUTPUT_DIR/$OUTPUT_FILE
