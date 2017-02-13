#! bin/bash/
#
# to get only unique DNA sequences of miRNA use following script 
# sed removes annotations; sort removes duplicates; tr replace U with T
sed -n 'n;p;' Nicotiana_miRNA.fa | sort -u | tr U T > Nicotiana_miRNA_DNA.fa
# -F interpret pattern as a list of fixed strings
# -f load from fileq
grep -F -f Nicotiana_miRNA_DNA.fa /home/marek/bfu/smRNA/H11_A_ATCACG_L006_R1_001.fastq
