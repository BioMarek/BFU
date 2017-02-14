#!/bin/bash
#

PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
DATASET_DIR=$PROJECT_DIR/trimmed # path to input raw sequences
OUTPUT_DIR=$PROJECT_DIR/counts # path to output sequences

mkdir $OUTPUT_DIR
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/discarded
cd $DATASET_DIR

for file in *trimmed.fastq
do
   # leaves sequences from fastq file and removes everything else
   sed -n 'n;p;n;n;' $file > ${file:0:12}_discarded_fasta.fasta
   mv ${file:0:12}_discarded_fasta.fasta /storage/brno7-cerit/home/marek_bfu/smRNA/discarded
done

cd /storage/brno7-cerit/home/marek_bfu/smRNA/discarded

for file in *discarded_fasta.fasta
do
   # second sort sorts based on second column numerically
   awk '{print length}' $file | sort | uniq -c | sort -n -k 2 > ${file:0:12}_counts.txt
   mv ${file:0:12}_counts.txt $OUTPUT_DIR
done

