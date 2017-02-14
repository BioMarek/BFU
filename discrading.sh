#!/bin/bash
#
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/discarded
cd /storage/brno7-cerit/home/marek_bfu/smRNA/trimmed

for file in *trimmed.fastq
do
   # leaves sequences from fastq file and removes everything else
   sed -n 'n;p;n;n;' $file > ${file:0:12}_discarded_fasta.fasta
   mv ${file:0:12}_discarded_fasta.fasta /storage/brno7-cerit/home/marek_bfu/smRNA/discarded
done

mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/counts
cd /storage/brno7-cerit/home/marek_bfu/smRNA/discarded

for file in *discarded_fasta.fasta
do
   # second sort sorts based on second column numerically
   awk '{print length}' $file | sort | uniq -c | sort -n -k 2 > ${file:0:12}_counts.txt
   mv ${file:0:12}_counts.txt /storage/brno7-cerit/home/marek_bfu/smRNA/counts
done

