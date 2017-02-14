#! bin/bash/
#
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA/
INPUT_DIR=$PROJECT_DIR/trimmed
OUTPUT_DIR=$PROJECT_DIR/collapsed

mkdir $OUTPUT_DIR
cd $INPUT_DIR

# to get only unique DNA sequences of miRNA use following script 
# sed removes annotations; sort removes duplicates; tr replace U with T
#sed -n 'n;p;' Nicotiana_miRNA.fa | sort -u | tr U T > Nicotiana_miRNA_DNA.fa

# sequencing files colapsing something like tally
for file in *.fastq
do
  sed -n 'n;p;n;n;' $file | sort | uniq -c | sort -n -r > $OUTPUT_DIR/${file:0:12}.txt
done

# -F interpret pattern as a list of fixed strings
# -f load from fileq
#grep -F -f Nicotiana_miRNA_DNA.fa /home/marek/bfu/smRNA/H11_A_ATCACG_L006_R1_001.fastq
