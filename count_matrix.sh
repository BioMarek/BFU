#! bin/bash/
#
# tr replace U with T; sed removes annotations; sort removes duplicates
cat Nicotiana_miRNA.fa  | tr U T | sed -n 'n;p;' | sort -u > Nicotiana_miRNA_DNA.fa
# -F interpret pattern as a list of fixed strings
# -f load from fileq
grep -F -f Nicotiana_miRNA_DNA.fa /home/marek/bfu/smRNA/H11_A_ATCACG_L006_R1_001.fastq
