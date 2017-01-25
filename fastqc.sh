#! /bin/bash
#
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/fastqc_after_trim

for file in *trimmed.fastq
do
   cp *.fasta $SCRATCH
done

for file in *trimmed.fastq
do
   fastqc $file
   cp *.zip /storage/brno7-cerit/home/marek_bfu/smRNA/fastqc_after_trim
done

rm -rf *
