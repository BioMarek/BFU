#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fa sequences of collapsed files, *.fa reference file
## SCRIPT OUTPUT *.bow file containing sorted alignments
# The script alignes reads to the reference using bowtie algorithm
# Start with: qsub -l walltime=4:0:0 -q default -l select=1:ncpus=4:mem=4gb:scratch_local=40gb -I
# Stop with:  qdel 

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/ncRNA/bowtie # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/ncRNA/aligned # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir $OUTPUT_DIR
cd $INPUT_DIR

module add bowtie-0.12.8
bowtie

# translate spaces to underscores because the name of sequence is truncated after first space
tr ' ' '_' < Nicotiana_Rfam_seq_no_duplicates.fa > Nicotiana_Rfam_seq_tr.fa
# create index
bowtie-build Nicotiana_Rfam_seq_tr.fa Nicotiana_Rfam

# aligning
for file in *collapsed.fa
do
  bowtie -f Nicotiana_Rfam $file | sort -k3 > $OUTPUT_DIR/${file:0:12}_aligned.bow
  # adds header necesary for pandas
  # sed  -i '1i aligned \t strand\t name \t position \t sequence \t I \t 0 \t mismatch' $OUTPUT_DIR/${file:0:12}_aligned.bow
done

# removes first line (description) so that we can use the python script in subsequent step
#cd $OUTPUT_DIR
#for file in *aligned.bow
#do
#      sed '1d' $file | sort -k 3 > temp
#      mv temp $file
#done

