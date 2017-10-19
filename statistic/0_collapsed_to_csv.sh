#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  3_collapsing_miRNA.sh
## SCRIPT OUTPUT 
# The script creates *.csv file from collapsed files

#######################################################################################################################
##SPECIFY DATA VARIABLES##
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR//miRNA/collapsed # path to input sequences
OUTPUT_DIR=$PROJECT_DIR/statistic/collapsed_csv

#######################################################################################################################
###SCRIPT BODY###
cd $DATASET_DIR
mkdir -p $OUTPUT_DIR

for file in *.txt
do
  awk '{ print $2 "," $1}' $file > ${file:0:12}.csv
  mv ${file:0:12}.csv $OUTPUT_DIR
done
