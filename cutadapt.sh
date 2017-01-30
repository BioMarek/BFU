#!/bin/bash
#
module add python27-modules-gcc
module add python27-modules-intel

cd /storage/brno7-cerit/home/marek_bfu/smRNA/raw_sequences

for file in *.fastq
do
  cp $file $SCRATCH
done

cd $SCRATCH
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/trimmed

for file in *.fastq
do
  # cuts adapter and tosses everything shorter than 1 base
  cutadapt -a TGGAATTCTCGGGTGCCAAGG -m 1 -o ${file:0:12}_trimmed.fastq $file
  mv ${file:0:12}_trimmed.fastq /storage/brno7-cerit/home/marek_bfu/smRNA/trimmed
done

rm -rf *
