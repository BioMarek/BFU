#!/bin/bash
#
# http://stackoverflow.com/questions/11006431/sort-by-third-column-leaving-first-and-second-column-intact-in-linux

for i in `cat your_file`
do 
  echo ${#i}$'\t'${i} 
done | sort -n | cut -f 2- > res
