#! /bin/bash
#
for file in *trimmed.fastq
do
   fastqc $file
done
