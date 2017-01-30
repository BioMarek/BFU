#! /bin/bash
#

QT_THRESHOLD=5
QF_THRESHOLD=10 # Threshold for quality filtering
QF_PERC=85 # Minimal percentage of bases with $QF_THRESHOLD
QUALITY=33 # Phred coding of input files
DISC_SHORT=15
DISC_LONG=40 # because of 30 something peak
INPUT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA/trimmed
OUTPUT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA/filtered

mkdir $OUTPUT_DIR
cd $INPUT_DIR

module add python27-modules-gcc  
module add python27-modules-intel
module add fastx-0.0.13

for file in *trimmed.fastq
do
   cp $file $SCRATCH
done

cd $SCRATCH

for sample in *
do
	# Cutadapt quality trimming, N bases removal and length filtering
	# for quality filtering we need Phred coding +33, otherwise --quality-base=$QUALITY
	cutadapt --quality-cutoff $QT_THRESHOLD,$QT_THRESHOLD --trim-n --max-n=0 --minimum-length $DISC_SHORT --maximum-length $DISC_LONG -o $OUTPUT_DIR/${file:0:12}_filtered.fasta $sample

	# Fastx-toolkit quality filtering; to use gz as input/output https://www.biostars.org/p/83237/
	# Cutadapt can trim only ends of the reads. To filter sequences with low qualitys in the middle, we need to use FastX
	fastq_quality_filter -Q $QUALITY -q $QF_THRESHOLD -p $QF_PERC -z -o $OUTPUT_DIR/${file:0:12}_mirna.fastq $sample	
done

rm -rf *
