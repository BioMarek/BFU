#! /bin/bash
#

for file in *discarded_fasta
do
  # second sort sorts based on second column numerically
  awk '{print length}' $file | sort | uniq -c | sort -n -k 2 > ${file:0:12}_counts.txt
done
