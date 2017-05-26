#!/bin/bash
#
# http://stackoverflow.com/questions/11006431/sort-by-third-column-leaving-first-and-second-column-intact-in-linux

for line in `cat H11_mapped.fasta | sed -n 'n;p;'
do 
  echo ${#line}$'\t'${line} 
done | sort -n | cut -f 2- > res
