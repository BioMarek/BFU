#!/bin/bash
#
# http://stackoverflow.com/questions/11006431/sort-by-third-column-leaving-first-and-second-column-intact-in-linux
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fasta files mapped to nptII gene
## SCRIPT OUTPUT *.txt 
# The script counts length and nuclieotide distribution of sequences so we can make graph

#######################################################################################################################
##SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/nptII/mapped_reads # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/nptII/first_nucleotide # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
# takes each line in file, keeps only sequence and removes everything else
mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *.fasta
do
  for line in `cat $file | sed -n 'n;p;'`
  do
    echo ${#line}$'\t'${line}
  done | sort -n | cut -f 2- > ${file:0:3}_sorted.txt
done
