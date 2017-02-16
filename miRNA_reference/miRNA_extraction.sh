#!/bin/bash
#
##############################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# Used to extract miRNA belonging to specific species from miRBase fasta file

##############################################################################################################################
##SPECIFY DATA VARIABLES###
SPECIES_ID=">nta" # >nta is unique identificator for Nicotiana tabacum miRNAs !!!TEST THIS!!!

##############################################################################################################################
###SCRIPT BODY###
sed -n '/$SPECIES_ID/{p;n;p}' mature.fa > Nicotiana_miRNA.fa
