#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT -  bare nucleotide sequences
## SCRIPT OUTPUT - bare nucleotide sequences combined from multiple files without duplicates
# The script creates reference file from multiple files by combineing multiple files and removing duplicates. It can be 
# later used as an input for 2_fasta_from_sequence.py

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/collapsed # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/reference # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
cd $INPUT_DIR
mkdir $OUTPUT_DIR

# creating empty file otherwise awk throws error
touch $OUTPUT_DIR/reference_all_temp.txt

# input are files with collapsed sequences first column is number of sequences in second column
for file in *.txt
do
  awk '{print $2}' $file >> $OUTPUT_DIR/reference_all_temp.txt
done

cd $OUTPUT_DIR
sort reference_all_temp.txt | uniq > $OUTPUT_DIR/reference_all.txt
chmod 700 $OUTPUT_DIR/reference_all.txt
rm reference_all_temp.txt
