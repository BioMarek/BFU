#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# This script runs the pipeline
# Start with: qsub -l walltime=12h -l mem=1gb -l scratch=40gb -l nodes=1:ppn=2 0_main.sh
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA
cd $PROJECT_DIR

#######################################################################################################################
###SCRIPT BODY###
for file in *.sh
do
  chmod 700 $file
  dos2unix $file
done

./storage/brno7-cerit/home/marek_bfu/smRNA/scripts/1_trimming.sh
./storage/brno7-cerit/home/marek_bfu/smRNA/scripts/miRNA/2_filtering_miRNA.sh
./storage/brno7-cerit/home/marek_bfu/smRNA/scripts/miRNA/3.1_fastqc_miRNA.sh
./storage/brno7-cerit/home/marek_bfu/smRNA/scripts/miRNA/3.2_counting_miRNA.sh
./storage/brno7-cerit/home/marek_bfu/smRNA/scripts/miRNA/3_collapsing_miRNA.sh
