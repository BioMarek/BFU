#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fasta file containing multiple sequences
## SCRIPT OUTPUT *.fasta files each containing single sequence
# The script creates file in *.fasta format from nucleotide sequence. Required for blast.

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/reference # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/test_blast # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR
count=1

# rework for 2 lines, if line starts with > create file and copy line into it else copy line into previous file
while read line
do
  if [ ${line:0:1} == '>' ] # if first line is description create new file 
  then
    touch "$OUTPUT_DIR"/Nicotiana_Rfam_seq_"$count"ref.fa
    temp="$OUTPUT_DIR"/Nicotiana_Rfam_seq_"$count"ref.fa # filename must be stored for the next cycle in which we save the sequence into said file
    echo $line >> $OUTPUT_DIR/Nicotiana_Rfam_seq_"$count"ref.fa
    count=$[count + 1]
  else
    # double quotes gets rid of "ambiguous redirect" error http://stackoverflow.com/questions/2462385/getting-an-ambiguous-redirect-error 
    echo $line >> "$temp"
  fi
done < Nicotiana_Rfam_seq.fa
