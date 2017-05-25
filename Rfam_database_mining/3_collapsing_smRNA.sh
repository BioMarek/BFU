#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz filtered sequences with proper length and high quality
## SCRIPT OUTPUT *.txt sequences where in the first column there is number of sequences which are in the second column
# The script collapses identical sequeces to sinlge one while keeping information about number of reads, something
# like Tally http://wwwdev.ebi.ac.uk/enright-dev/kraken/reaper/src/reaper-latest/doc/tally.html
# sequences with only one hit are discarded

PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/ncRNA/filtered # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/ncRNA/collapsed # path to output sequences

mkdir -p $OUTPUT_DIR
cd $INPUT_DIR

#######################################################################################################################
###SCRIPT BODY###
for file in *mirna.fastq.gz
do
  # gunzip -c unpacks wihout modifying the input file and sends result to STDOUT
  # sed removes evrything but sequences
  # uniq counts how many sequences of each type there is (first sort is there because uniq requires adjacent matching lines) 
  # second sort sorts numericaly in reverse order
  # grep removes sequences with sigle hit (multiple spaces than number 1 and then space)
  gunzip -c $file | sed -n 'n;p;n;n;' | sort | uniq -c | sort -n -r | grep -v '^[ ]*1 ' > $OUTPUT_DIR/${file:0:12}.txt
  # chmod sets access right so that only owner can work with file
  chmod 700 $OUTPUT_DIR/${file:0:12}.txt
done
