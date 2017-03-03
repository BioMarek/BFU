#! /bin/bash
#

for file in *.fa.gz
do
  gunzip - c $file | grep "Nicotiana tabacum"
done
