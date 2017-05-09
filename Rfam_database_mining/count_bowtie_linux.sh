#! /bin/bash
#
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/aligned # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/bow_counts

mkdir $OUTPUT_DIR
cd $INPUT_DIR

module add python26-modules-gcc
module add python26-modules-intel

# runs python script
python $PROJECT_DIR/scripts/4_count_bowtie.py

mv *_aligned.bow $OUTPUT_DIR
