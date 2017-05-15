#!/bin/bash
#

for i in `cat your_file`
do 
  echo ${#i}$'\t'${i} 
done | sort -n | cut -f 2- > res
