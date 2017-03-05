#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  bare nucleotide sequences
## SCRIPT OUTPUT file in fasta format which can be used as an input for any script that requires fasta as an input
# The script takes preprocessed bare sequences and creates proper FASTA file from them. So that the file can be used
# as reference for 4_count_matrix_miRNAs.py script.

#######################################################################################################################
###SPECIFY DATA VARIABLES###
# description in each fasta file
description = ' smRNA Nicotiana tabacum\n'

#######################################################################################################################
###SCRIPT BODY###
import datetime

# reading lines from file reads them with '\n' chars, this function removes them
def remove_enter(line):
    line2 = ""
    for i in range(len(line) - 1):
        line2 += line[i]
    return line2

start = datetime.datetime.now()
print('Start time: ', start)

f_input = open('reference_all.txt', 'r')
f_result = open('reference_all.fa', 'w')

# we have only sequence without any name or identifier so this creates fasta from just sequence
for line in f_input:
    final_result = ('>' + remove_enter(line) + description + line)
    f_result.write(final_result)

f_result.close()
f_input.close()
end = datetime.datetime.now()
print('Start time: ', start, '  End time: ', end, '  It took: ', end - start)
