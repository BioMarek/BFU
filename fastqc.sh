#! /bin/bash
#
mkdir /storage/brno7-cerit/home/marek_bfu/smRNA/fastqc_after_trim
cd /storage/brno7-cerit/home/marek_bfu/smRNA/trimmed

for file in *trimmed.fastq
do
   cp *.fastq $SCRATCH
done

cd $SCRATCH
module add fastQC-0.10.1

for file in *trimmed.fastq
do
   fastqc $file  
done

cp *.zip /storage/brno7-cerit/home/marek_bfu/smRNA/fastqc_after_trim
rm -rf *
