#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# This script runs the pipeline
# Start with: qsub -l walltime=12:0:0 -q default -l select=1:ncpus=2:mem=2gb:scratch_local=40gb 0_main_miRNA.sh
# Stop with:  qdel 

#######################################################################################################################
##SPECIFY DATA VARIABLES##
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
DATASET_DIR=$PROJECT_DIR/scripts/statistics # path to input scripts

###############################################################################$
###SCRIPT BODY###
chmod 700 *.sh
dos2unix *.sh

./1_collapsed_to_csv.sh
./2_statistics_pandas.sh
