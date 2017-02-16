#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# This script runs the pipeline
# Start with: qsub -l walltime=12h -l mem=2gb -l scratch=100gb -l nodes=1:ppn=2 0_main.sh
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA/
cd $PROJECT_DIR

#######################################################################################################################
###SCRIPT BODY###
for file in *.sh
do
  chmod 700 $file
  dos2unix $file
done

./1_trimming.sh
./2_filtering.sh
./3.1_fastqc.sh
./3.2_counting.sh
./3_collapsing.sh
