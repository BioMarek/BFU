#! /bin/bash
#
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA/
INPUT_DIR=$PROJECT_DIR/filtered
OUTPUT_DIR=$PROJECT_DIR/collapsed

mkdir $OUTPUT_DIR
cd $INPUT_DIR

##################################################################################################
##REFERENCE FILE MODIFICATION##
# to get only unique DNA sequences of miRNA use following script 
# sed removes annotations; sort removes duplicates; tr replace U with T
#sed -n 'n;p;' Nicotiana_miRNA.fa | sort -u | tr U T > Nicotiana_miRNA_DNA.fa

##################################################################################################
##SEQUENCING FILES MODIFICATION##
# sequencing files colapsing something like tally
for file in *.fastq.gz
do
  # gunzip -c unpacks wihout modifying the input file and sends result to STDOUT; sed removes evrything but sequences; 
  # uniq counts how many sequences of each type there is (first sort is there because uniq requires adjacent matching lines); 
  # second sort sorts numericaly in reverse order
  gunzip -c $file | sed -n 'n;p;n;n;' | sort | uniq -c | sort -n -r > $OUTPUT_DIR/${file:0:12}.txt
  # chmod sets access right so that only owner can work with file
  chmod 700 $OUTPUT_DIR/${file:0:12}.txt
done

##################################################################################################
##MATRIX CREATION##
# -F interpret pattern as a list of fixed strings
# -f load from fileq
#grep -F -f Nicotiana_miRNA_DNA.fa /home/marek/bfu/smRNA/H11_A_ATCACG_L006_R1_001.fastq

# second version
# maybe use -c for counting
# -w select only exact matches
#cat $PROJECT_DIR/reference/Nicotiana_miRNA_DNA.fa | while IFS= read -r line 
#do
#  grep -w '$line' H11_A_ATCACG.txt > pok.txt
#done

#!/bin/bash
#names="/storage/brno7-cerit/home/marek_bfu/smRNA/reference/Nicotiana_miRNA_DNA.fa"
#grades="/storage/brno7-cerit/home/marek_bfu/smRNA/collapsed/H11_A_ATCACG.txt"
#grep -fi "${names}" "${grades}"

#!/bin/bash
while read line; do
  grep -w "$line" /storage/brno7-cerit/home/marek_bfu/smRNA/collapsed/H11_A_ATCACG.txt
done < /storage/brno7-cerit/home/marek_bfu/smRNA/reference/Nicotiana_miRNA_DNA.fa > pok.txt

grep -f /storage/brno7-cerit/home/marek_bfu/smRNA/reference/Nicotiana_miRNA_DNA.fa /storage/brno7-cerit/home/marek_bfu/smRNA/collapsed/H11_A_ATCACG.txt > pok.txt


