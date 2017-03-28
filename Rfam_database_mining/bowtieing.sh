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
bowtie

# translate spaces to underscores because the name of sequence is truncated after first space
tr ' ' '_' < Nicotiana_Rfam_seq.fa > Nicotiana_Rfam_seq_tr.fa
# create index
bowtie-build Nicotiana_Rfam_seq_tr.fa Nicotiana_Rfam

# align
for file in *collapsed.fa
do
  bowtie -f Nicotiana_Rfam $file | sort -t: -k2 > $OUTPUT_DIR/${file:0:12}_aligned.bow
done
