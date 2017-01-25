#!/bin/bash
#
module add python27-modules-gcc
module add python27-modules-intel

for file in *.fastq
do
  mv $file $SCRATCH
done

cd $SCRATCH

for file in *.fastq
do
  # cuts adapter and tosses everything shorter than 1 base
  cutadapt -a TGGAATTCTCGGGTGCCAAGG -m 1 -o ${file:0:12}_trimmed.fastq $file
done

mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/trimmed
mv * /storage/brno7-cerit/home/marek_bfu/smRNA/trimmed
rm -rf *
