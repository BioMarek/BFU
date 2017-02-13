#! bin/bash/
#
# replace U with T
cat Nicotiana_miRNA.fa  | tr U T > Nicotiana_miRNA_DNA.fa
# -F interpret pattern as a list of fixed strings
# -f load from file
grep -F -f Nicotiana_miRNA_DNA.fa /home/marek/bfu/smRNA/H11_A_ATCACG_L006_R1_001.fastq
