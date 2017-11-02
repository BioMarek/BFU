#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  
## SCRIPT OUTPUT 2_statistics_pandas.py results
# The script runs 2_statistics_pandas.py script and stores the results into proper directory

#######################################################################################################################
###SPECIFY DATA VARIABLES###
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/scripts/statistics # path to input scripts
OUTPUT_DIR=$PROJECT_DIR/statistic/basic_stat_result # directory for results of 2_statistics_pandas.py script

#######################################################################################################################
###SCRIPT BODY###
mkdir -p $OUTPUT_DIR

# adding modules and running python script which creates *.counts
module add python34-modules-gcc
module add python34-modules-intel
python $INPUT_DIR/2_statistics_pandas.py

# TODO copy results into output dir
