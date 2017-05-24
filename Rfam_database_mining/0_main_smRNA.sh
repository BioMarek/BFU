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
cd $PROJECT_DIR/ncRNA/scripts
chmod 700 *.sh
dos2unix *.sh

./2_filtering_smRNA.sh
./3_collapsing_smRNA.sh
./4_fasta_from_collapsed_smRNA.sh
./5_bowtieing_smRNA.sh
./6_count_bowtie_smRNA.sh
