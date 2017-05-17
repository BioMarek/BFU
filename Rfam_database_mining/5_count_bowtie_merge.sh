#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.count files from 4_count_bowtie.sh script
## SCRIPT OUTPUT *.counts count matrix
# The script merges *.count files from 4_count_bowtie.sh script in order to get count matrix

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/bow_counts # path to input sequences and reference
OUTPUT_DIR=$INPUT_DIR

#######################################################################################################################
###SCRIPT BODY###

cd $INPUT_DIR

# creates matrix file
paste H11_A_ATCACG_aligned.counts H11_B_CGATGT_aligned.counts P1_A_CAGATC__aligned.counts P1_B_ACTTGA__aligned.counts \
      P3_A_GATCAG__aligned.counts P3_B_TAGCTT__aligned.counts P8_A_TTAGGC__aligned.counts P8_B_TGACCA__aligned.counts \
      REG_A_ACAGTG_aligned.counts REG_B_GCCAAT_aligned.counts > ncRNA_matrix_count.counts

# add header, we have to go through temporary file because we cannot modify file and at the same time redirect 
# output into it
sed '1 i\name\t H11_A \tH11_B \tP1_A \tP1_B \tP3_A \tP3_B \tP8_A \tP8_B \tREG_A \tREG_B' ncRNA_matrix_count.counts > temp
mv temp /ncRNA_matrix_count.counts
