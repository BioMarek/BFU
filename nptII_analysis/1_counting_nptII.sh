#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fasta reads mapped to nptII gene from geneious
## SCRIPT OUTPUT *.txt files with length counts

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/nptII/mapped_reads # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/nptII/counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir -p $OUTPUT_DIR
cd $DATASET_DIR

module add python26-modules-gcc
module add python26-modules-intel

for file in *.fasta
do
   python /storage/brno7-cerit/home/marek_bfu/smRNA/scripts/nptII/1_counting_nptII.py $file
   sort -k1 ${file:0:3}_count.txt > temp
   mv temp $OUTPUT_DIR/${file:0:3}_count.txt
   sed  -i '1i length\tA\tC\tG\tT' $OUTPUT_DIR/${file:0:3}_count.txt
   chmod 700 $OUTPUT_DIR/${file:0:3}_count.txt
done

module unload python26-modules-gcc
module unload python26-modules-intel
