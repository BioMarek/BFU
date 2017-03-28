#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fa sequences of collapsed files
## SCRIPT OUTPUT 

# module add pbspro-client
# qsub -l walltime=4:0:0 -l select=1:ncpus=4:mem=4gb:scratch_local=40gb -I

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/bowtie # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/aligned # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR

module add bowtie-0.12.8

cp * $SCRATCH
cd $SCRATCH

#######################################################################################################################
###CREATING SINLGE FILES FROM REFERENCE###
## translate spaces to underscores because the name of sequence is truncated after first space
#tr ' ' '_' < Nicotiana_Rfam_seq.fa > Nicotiana_Rfam_seq_tr.fa
# rework for 2 lines, if line starts with > create file and copy line into it else copy line into previous file
while read line
do
  if [ ${line:0:1} == '>' ] # if first line is description create new file 
  then
    touch "$line"_ref.fa
    temp="$line"_ref.fa # filename must be stored for the next cycle in which we save the sequence into said file
    echo $line >> "$line"_ref.fa
  else
    # double quotes gets rid of "ambiguous redirect" error http://stackoverflow.com/questions/2462385/getting-an-ambiguous-redirect-error 
    echo $line >> "$temp"
  fi
done < Nicotiana_Rfam_seq.fa


#######################################################################################################################
###BOWTIE ALIGNMENT###

for reference in *ref.fa 
do
  # for each file creates reference index, the names are always same so they are rewritten
  bowtie-build $reference Nicotiana_Rfam
  # align
  for file in *collapsed.fa
  do
    bowtie -f Nicotiana_Rfam $file | sort -t: -k2 > $OUTPUT_DIR/"$reference"_${file:0:5}_aligned.bow
  done
done

rm *
