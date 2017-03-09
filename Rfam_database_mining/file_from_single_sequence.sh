#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fasta file containing multiple sequences 
## SCRIPT OUTPUT *.fasta files each containing single sequence

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/reference # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/blast # path to output sequences

#######################################################################################################################
###SCRIPT BODY###

# rework for 2 lines
while read line; do
    touch "${line}.txt"
done <  Nicotiana_Rfam_seq.fa
