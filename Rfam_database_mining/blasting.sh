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
module add blast+-2.2.27

mkdir $OUTPUT_DIR
cd $INPUT_DIR

cp * $SCRATCH

###CREATION OF SUBJECT FILES###
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

###CREATION OF QUERY FILES###
while read line
do
  count=$[count + 1]
  if [ ${line:0:1} == '>' ] # if first line is description create new file 
  then
    touch H11_A_ATCACG_"$count"_que.fa
    temp=H11_A_ATCACG_"$count"_que.fa # filename must be stored for the next cycle in which we save the sequence into said file
    echo $line >> H11_A_ATCACG_"$count"_que.fa
  else
    # double quotes gets rid of "ambiguous redirect" error http://stackoverflow.com/questions/2462385/getting-an-ambiguous-redirect-error 
    echo $line >> "$temp"
  fi
done < H11_A_ATCACG_collapsed.fa


###BLASTING###
blastn -query que2.fa -subject que.fa > result
# -q tells grep to retun only exit status; 0 if somethig was found; different number otherwise
if grep -q "No hits found" result
then
  rm result
else
   grep -o -P '(?<=Query= ).*(?= )' >> res # saves number of sequences that had been succesfully matched to res file
   echo \n >> res # adds new line there is porbably better way
fi

