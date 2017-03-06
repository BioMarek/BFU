#!/bin/bash
#
##############################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# Used to extract sequences belonging to specific species from Rfam offline database fasta files

##############################################################################################################################
##SPECIFY DATA VARIABLES###
SPECIES_ID="Nicotiana tabacum" # unique identificator for Nicotiana tabacum ncRNAs
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/rfam/12.2/fasta_files # path to input filtered sequences
OUTPUT_DIR=$PROJECT_DIR/reference # path to output sequences

##############################################################################################################################
###SCRIPT BODY###
cd $INPUT_DIR

for file in *.fa.gz
do
  # double quotes because of some stupid subtitution behaviour 
  # See: http://stackoverflow.com/questions/584894/sed-scripting-environment-variable-substitution
  gunzip -c $file | sed -n "/$SPECIES_ID/{p;n;p}" >> $OUTPUT_DIR/Nicotiana_Rfam_seq.fa
done

chmod 700 $OUTPUT_DIR/Nicotiana_Rfam_seq.fa
