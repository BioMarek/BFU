#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# This script runs the pipeline
# Start with: qsub -l walltime=12:0:0 -q default -l select=1:ncpus=2:mem=2gb:scratch_local=40gb 0_main_miRNA.sh
# Stop with:  qdel 
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA

#######################################################################################################################
###SCRIPT BODY###
cd $PROJECT_DIR/scripts/
chmod 700 *.sh
dos2unix *.sh
./1_trimming.sh

cd /storage/brno7-cerit/home/marek_bfu/smRNA/scripts/miRNA
chmod 700 *.sh
dos2unix *.sh
./2_filtering_miRNA.sh
./3.1_fastqc_miRNA.sh
./3.2_counting_miRNA.sh
./3_collapsing_miRNA.sh
