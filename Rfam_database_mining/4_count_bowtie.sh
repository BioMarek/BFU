#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.bow files from bowtie
## SCRIPT OUTPUT *.counts matrix of file given as argument
# The script runs python script to get counts of *.bow file given as argument
# Run using: qsub -l walltime=12:0:0 -q default -l select=1:ncpus=1:mem=1gb:scratch_local=1gb 4_count_bowtie.sh

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/aligned # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/bow_counts # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR
cp * $SCRATCH
cd $SCRATCH

# removes first line and sorts all files based on their name (third column)
for file in *aligned.bow
do
      sed '1d' $file | sort -k 3 > temp
      mv temp $file
done

module add python26-modules-gcc
module add python26-modules-intel

# runs python script with argument telling which file to work on
cp $PROJECT_DIR/scripts/4_count_bowtie.py $SCRATCH
python 4_count_bowtie.py $1

cp *.counts $OUTPUT_DIR

rm *
