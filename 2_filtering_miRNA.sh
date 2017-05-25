#! /bin/bash
#
#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.fastq.gz sequences without adapter
## SCRIPT OUTPUT *.fastq.gz filtered sequences with proper length and high quality
# The script removes sequences that are too short or long and performs quality filtering using FASTX

#######################################################################################################################
##SPECIFY DATA VARIABLES###
QT_THRESHOLD=5
QF_THRESHOLD=10 # Threshold for quality filtering
QF_PERC=85 # Minimal percentage of bases with $QF_THRESHOLD
QUALITY=33 # Phred coding of input files
DISC_SHORT=15 # trim shorater than
DISC_LONG=40 # trim longer than, it that high because of because of 30 something peak in nicotiana
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/trimmed # path to input sequences without adapters
OUTPUT_DIR=$PROJECT_DIR/miRNA/filtered # path to output sequences

#######################################################################################################################
###SCRIPT BODY###
mkdir -p $OUTPUT_DIR
cd $INPUT_DIR

module add python27-modules-gcc  
module add python27-modules-intel
module add fastx-0.0.13

for file in *trimmed.fastq.gz
do
   cp $file $SCRATCH
done

cd $SCRATCH

for file in *.fastq.gz
do
	# Cutadapt quality trimming, N bases removal and length filtering
	# for quality filtering we need Phred coding +33, otherwise --quality-base=$QUALITY
	# !!!CHECK WHETHER GOOD IDEA AND HOW CUTADAPT TRIMING WORKS!!!
	cutadapt --quality-cutoff $QT_THRESHOLD,$QT_THRESHOLD --trim-n --max-n=0 --minimum-length $DISC_SHORT --maximum-length $DISC_LONG -o ${file:0:12}_filtered.fastq.gz $file
	# Cutadapt can trim only ends of the reads. To filter sequences with low qualitys in the middle, we need to use FastX
	gunzip -c ${file:0:12}_filtered.fastq.gz | fastq_quality_filter -Q $QUALITY -q $QF_THRESHOLD -p $QF_PERC -z -o ${file:0:12}_mirna.fastq.gz
	# when working in $SCRATCH I do calculation first and then move files with results in order to take advantage of SSDs
	mv ${file:0:12}_mirna.fastq.gz $OUTPUT_DIR
done

rm -rf *

# in subsequent steps different python modules are required, when two version of python module are loaded scripts
# dont't work as intended
module unload python27-modules-gcc 
module unload python27-modules-intel
