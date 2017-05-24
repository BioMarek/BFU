#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.txt contining collapsed sequences
## SCRIPT OUTPUT *.fa file containing collapsed files
# The script creates *.fa file from collapsed files so that metacentrum blastn can use them. In the decription is 
# number of each sequence followed by nucleotide sequence


#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/ncRNA/collapsed # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/ncRNA/bowtie # path to output sequences

#######################################################################################################################

###SCRIPT BODY###
cd $INPUT_DIR

for file in *.txt
do
  # in the description there is number of sequences
  awk '{print ">" $1 "\n" $2}' $file > $OUTPUT_DIR/${file:0:12}_collapsed.fa
done
