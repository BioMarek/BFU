#! /bin/bash
#
##############################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fa sequences of collapsed files
## SCRIPT OUTPUT *.txt with number of how many sequences was mapped
# The script blasts two files. If there is match it takes number of sequence that has been matched and adds it to variable 
# holding number of mapped reads.

##############################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/blast # path to input sequences
REFERENCE_FILE=$PROJECT_DIR/reference/Nicotiana_Rfam_seq.fa
OUTPUT_DIR=$PROJECT_DIR/blasted # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR

cp * $SCRATCH

###CREATION OF REFERENCE FILES###



###BLASTING###
blastn -query que2.fa -subject que.fa
