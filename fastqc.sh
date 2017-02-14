#! /bin/bash
#

PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/trimmed # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/fastqc_after_trim # path to output sequences

mkdir $OUTPUT_DIR
cd $DATASET_DIR

for file in *trimmed.fastq
do
   cp $file $SCRATCH
done

cd $SCRATCH
module add fastQC-0.10.1

for file in *trimmed.fastq
do
   fastqc $file  
done

cp *.zip $OUTPUT_DIR
rm -rf *
