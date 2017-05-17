#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.bow files from bowtie
## SCRIPT OUTPUT *.counts matrix file containing counts from all files
# The script runs python script to get counts and creates matrix from them for further analyses

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/aligned # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/bow_counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR
cp * $SCRATCH
cd $SCRATCH

# removes first line and sorts all files based on their name (third column)
for file in *aligned.bow
do
      sed '1d' $file | sort -k 3 > temp
      mv temp $file
done

module add python26-modules-gcc
module add python26-modules-intel

# runs python script with argument telling which file to work on
cp $PROJECT_DIR/scripts/4_count_bowtie.py $SCRATCH
python 4_count_bowtie.py $1

# creates matrix file
paste H11_A_ATCACG_aligned.counts H11_B_CGATGT_aligned.counts P1_A_CAGATC__aligned.counts P1_B_ACTTGA__aligned.counts \
      P3_A_GATCAG__aligned.counts P3_B_TAGCTT__aligned.counts P8_A_TTAGGC__aligned.counts P8_B_TGACCA__aligned.counts \
      REG_A_ACAGTG_aligned.counts REG_B_GCCAAT_aligned.counts > ncRNA_matrix_count.counts

# add header, we have to go through temporary file because we cannot modify file and at the same time redirect 
# output into it
sed '1 i\name\t H11_A \tH11_B \tP1_A \tP1_B \tP3_A \tP3_B \tP8_A \tP8_B \tREG_A \tREG_B' ncRNA_matrix_count.counts > temp
mv temp $OUTPUT_DIR/ncRNA_matrix_count.counts

rm *
