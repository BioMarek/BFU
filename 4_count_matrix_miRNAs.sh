#TODO test it
#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.txt collapsed file from 3_collapsing.sh script
## SCRIPT OUTPUT *.counts matrix file containing counts from all files
# The script runs python script to get counts and creates matrix from them for further analyses

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/collapsed # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/count_matrix_all # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR

module add python27-modules-gcc
module add python27-modules-intel

# runs python script to remove duplicates
cd $PROJECT_DIR/reference
python $PROJECT_DIR/scripts/4.1_remove_duplicates.py
# copies reference file to INPUT_DIR so that all input files are in one place
mv Nicotiana_miRNA_D_no_duplicates.fa $INPUT_DIR

# runs python script to create count matrix
cd $INPUT_DIR
python $PROJECT_DIR/scripts/4_count_matrix_miRNAs.py

mv *.counts $OUTPUT_DIR
cd $OUTPUT_DIR

# creates matrix file
paste H11_A_ATCACG_temp.counts H11_B_CGATGT_temp.counts P1_A_CAGATC__temp.counts P1_B_ACTTGA__temp.counts \
      P3_A_GATCAG__temp.counts P3_B_TAGCTT__temp.counts P8_A_TTAGGC__temp.counts P8_B_TGACCA__temp.counts \
      REG_A_ACAGTG_temp.counts REG_B_GCCAAT_temp.counts > counts_all.counts

# add header, we have to go through temporary file because we cannot modify file and at the same time redirect 
# output into it
sed '1 i\name\t H11_A \tH11_B \tP1_A \tP1_B \tP3_A \tP3_B \tP8_A \tP8_B \tREG_A \tREG_B' counts_all.counts > temp
mv temp counts_all.counts
