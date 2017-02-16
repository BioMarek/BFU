#! /bin/bash
#
for file in *.sh
do
  chmod 700 $file
  dos2unix $file
done

./1_trimming.sh
./2_filtering.sh
./3.1_fastqc.sh
./3.2_counting.sh
./3_collapsing.sh
