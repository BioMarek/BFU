#! /bin/bash
#
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA/ # path to project dir
INPUT_DIR=$PROJECT_DIR/collapsed # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/reference # path to output sequences

cd $INPUT_DIR
mkdir $OUTPUT_DIR

# input are files with collapsed sequences first column is number of sequences in second column
for file in *.txt
do
  awk '{print $2}' $file >> reference_all_temp.txt
done

uniq  reference_all_temp.txt > $OUTPUT_DIR/reference_all.txt
rm reference_all_temp.txt
