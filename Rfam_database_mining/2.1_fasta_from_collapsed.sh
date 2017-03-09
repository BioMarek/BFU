#! /bin/bash
#
##############################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# The script creates *.fa file from collapsed files so that metacentrum blastn can use them

##############################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/collapsed # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/blast # path to output sequences

cd $INPUT_DIR

for file in *.txt
do
  # in the description there is sequence as a "name" and number of these sequences delimited by '|' character
  awk '{print ">" $2 "|" $1 "\n" $2}' $file > $OUTPUT_DIR/${file:0:12}_collapsed.fa
done
