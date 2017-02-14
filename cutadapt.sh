#!/bin/bash
#

PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/raw_sequences # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/trimmed # path to output sequences

module add python27-modules-gcc
module add python27-modules-intel

cd $DATASET_DIR

for file in *.fastq
do
  cp $file $SCRATCH
done

cd $SCRATCH
mkdir $OUTPUT_DIR

for file in *.fastq
do
  # cuts adapter and tosses everything shorter than 1 base
  cutadapt -a TGGAATTCTCGGGTGCCAAGG -m 1 -o ${file:0:12}_trimmed.fastq $file
  mv ${file:0:12}_trimmed.fastq $OUTPUT_DIR
done

rm -rf *
