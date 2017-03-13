#! /bin/bash
#
##############################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fa sequences of collapsed files
## SCRIPT OUTPUT *.txt with number of how many sequences was mapped
# The script blasts two files. If there is match it takes number of sequence that has been matched and adds it to variable 
# holding number of mapped reads.

##############################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/blast # path to input sequences
OUTPUT_DIR=$PROJECT_DIR/blasted # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR

cp * $SCRATCH
cp $REFERENCE_DIR/$REFERENCE_FILE $SCRATCH

###CREATION OF REFERENCE FILES###
while read line
do
  count=$[count + 1]
  if [ ${line:0:1} == '>' ] # if first line is description create new file 
  then
    touch Nicotiana_Rfam_seq_"$count"ref.fa
    temp=Nicotiana_Rfam_seq_"$count"ref.fa # filename must be stored for the next cycle in which we save the sequence into said file
    echo $line >> Nicotiana_Rfam_seq_"$count"ref.fa
  else
    # double quotes gets rid of "ambiguous redirect" error http://stackoverflow.com/questions/2462385/getting-an-ambiguous-redirect-error 
    echo $line >> "$temp"
  fi
done < Nicotiana_Rfam_seq.fa



###BLASTING###
blastn -query que2.fa -subject que.fa
