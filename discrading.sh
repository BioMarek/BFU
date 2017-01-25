#!/bin/bash
#
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/discarded

for file in *trimmed.fastq
do
   # leaves sequences from fastq file and removes everything else
   sed -n 'n;p;n;n;' $file > ${file:0:12}_discarded_fasta.fasta
   mv ${file:0:12}_discarded_fasta.fasta /storage/brno7-cerit/home/marek_bfu/smRNA/discarded
done

