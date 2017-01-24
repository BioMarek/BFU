#! /bin/bash
#
for file in *
do
  fastqc $file
done
