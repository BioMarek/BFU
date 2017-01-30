#! /bin/bash
#
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/counts
cd /storage/brno7-cerit/home/marek_bfu/smRNA/discarded

for file in *discarded_fasta.fasta
do
   # second sort sorts based on second column numerically
   awk '{print length}' $file | sort | uniq -c | sort -n -k 2 > ${file:0:12}_counts.txt
   mv ${file:0:12}_counts.txt /storage/brno7-cerit/home/marek_bfu/smRNA/counts
done
