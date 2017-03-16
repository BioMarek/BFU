#! /bin/bash
#
##############################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## run with qsub -l walltime=2d -l mem=100mb -l scratch=40gb:ssd -l nodes=1:ppn=1 blasting.sh
## SCRIPT INPUT  *.fa sequences of collapsed files
## SCRIPT OUTPUT *.txt with number of how many sequences was mapped
# The script blasts two files. If there is match it takes number of sequence that has been matched and adds it to variable 
# holding number of mapped reads.

##############################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/blast # path to input sequences
OUTPUT_DIR=$PROJECT_DIR/blasted # path to output sequences
FILE=H11_A_ATCACG # file which is being calculated

#######################################################################################################################
###SCRIPT BODY###
module add blast+-2.2.27

mkdir $OUTPUT_DIR
cd $INPUT_DIR
cp * $SCRATCH
cd $SCRATCH

###CREATION OF SUBJECT FILES###
count=1

while read line
do 
  if [ ${line:0:1} == '>' ] # if first line is description create new file
  then
    touch Sub_"$count"ref.fa
    temp=Sub_"$count"ref.fa # filename must be stored for the next cycle in which we save the sequence into said file
    echo $line >> Sub_"$count"ref.fa
    count=$[count + 1]
  else
    # double quotes gets rid of "ambiguous redirect" error http://stackoverflow.com/questions/2462385/getting-an-ambiguous-redirect-error 
    echo $line >> "$temp"
  fi
done < Nicotiana_Rfam_seq.fa

###CREATION OF QUERY FILES###
count=1

while read line
do
  if [ ${line:0:1} == '>' ] # if first line is description create new file
  then
    touch "$FILE"_"$count"_que.fa
    temp="$FILE"_"$count"_que.fa # filename must be stored for the next cycle in which we save the sequence into said file
    echo $line >> "$FILE"_"$count"_que.fa
    count=$[count + 1]
  else
    # double quotes gets rid of "ambiguous redirect" error http://stackoverflow.com/questions/2462385/getting-an-ambiguous-redirect-error 
    echo $line >> "$temp"
  fi
  # first 50000 most numerous sequences this should take 40h to complete
done < "$FILE"_collapsed_temp.fa


###BLASTING###
for SUBJECT in *ref.fa
do
  touch "$FILE"_"$SUBJECT"_hits.txt
  cat "$SUBJECT" >> "$SUBJECT"_hits.txt # adds name and nucleotide sequence to the result file
  RESULT=0

  for QUERY in *que.fa
  do
    blastn -query $QUERY -subject $SUBJECT > result
    # -q tells grep to retun only exit status; 0 if somethig was found; different number otherwise
    if ! grep -q "No hits found" result
    then
      # -o print only the matched (non-empty) parts of matching lines
      # -P interpret the pattern as a Perl-compatible regular expression (PCRE)
      RESULT=$[RESULT + grep -o -P '(?<=Query= ).*(?= )' result]  # saves number of sequences that had been succesfully matched to res file
    fi
  done
  
  $RESULT >> "$SUBJECT"_hits.txt
  cp "$SUBJECT"_hits.txt $OUTPUT_DIR
done

rm *

