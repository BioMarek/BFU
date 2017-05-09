#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.bow files from bowtie
## SCRIPT OUTPUT 
# The script runs python script to get counts

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/aligned # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/bow_counts

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR

module add python26-modules-gcc
module add python26-modules-intel

# runs python script
python $PROJECT_DIR/scripts/4_count_bowtie.py

mv *.counts $OUTPUT_DIR
cd $OUTPUT_DIR

paste H11_A_ATCACG_aligned.counts H11_B_CGATGT_aligned.counts P1_A_CAGATC__aligned.counts P1_B_ACTTGA__aligned.counts \
      P3_A_GATCAG__aligned.counts P3_B_TAGCTT__aligned.counts P8_A_TTAGGC__aligned.counts P8_B_TGACCA__aligned.counts \
      REG_A_ACAGTG_aligned.counts REG_B_GCCAAT_aligned.counts > ncRNA_matrix_count.counts
