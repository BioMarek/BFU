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

# create index
bowtie-build Nicotiana_Rfam_seq.fa Nicotiana_Rfam

# align
for file in *collapsed.fa
do
  bowtie Nicotiana_Rfam $file > $OUTPUT_DIR/${file:0:12}_aligned.bow
done
