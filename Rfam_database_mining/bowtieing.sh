#! /bin/bash
#
# module add pbspro-client
# qsub -l walltime=4:0:0 -l select=1:ncpus=4:mem=4gb:scratch_local=40gb -I

module add bowtie-0.12.8
bowtie

# difference between
# module add bowtie2-2.3.0
# bowtie2

# create index
bowtie-build Nicotiana_Rfam_seq.fa Nicotiana_Rfam
