#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.bow file containing sorted alignments from 3_bowtieing.sh
## SCRIPT OUTPUT *.counts file with count matrix for DESeq2 analysis
# The script creates count matrix from *.aligned.counts

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/aligned # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/bow_counts # path to output

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR

# adding modules and running python script which creates *.counts
python27-modules-gcc
python27-modules-intel
python 4_count_bowtie.py

# creates matrix file
paste H11_A_ATCACG_aligned.counts H11_B_CGATGT_aligned.counts P1_A_CAGATC__aligned.counts P1_B_ACTTGA__aligned.counts \
      P3_A_GATCAG__aligned.counts P3_B_TAGCTT__aligned.counts P8_A_TTAGGC__aligned.counts P8_B_TGACCA__aligned.counts \
      REG_A_ACAGTG_aligned.counts REG_B_GCCAAT_aligned.counts > ncRNA_matrix_count.counts

# add header, we have to go through temporary file because we cannot modify file and at the same time redirect 
# output into it
sed '1 i\name\t H11_A \tH11_B \tP1_A \tP1_B \tP3_A \tP3_B \tP8_A \tP8_B \tREG_A \tREG_B' ncRNA_matrix_count.counts > temp
mv temp ncRNA_matrix_count.counts
