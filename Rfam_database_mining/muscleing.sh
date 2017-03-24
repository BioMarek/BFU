#! /bin/bash
#

module add muscle-3.8.31

# clw clustal file format
muscle -in $INPUT -out $OUTPUT -clw

more than 3 '-' abort
less than 90% '*' abort
