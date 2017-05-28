#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# The script counts number of starting nucleotides for each particular sequence length, works for fasta format
# or bare sequences

#######################################################################################################################
###SCRIPT BODY###
import sys


# The class stores nucleotide count for particular sequence length
class Storage:
    def __init__(self, length):
        self.m_length = length
        self.a_count = 0
        self.c_count = 0
        self.g_count = 0
        self.t_count = 0

    def add(self, nucleotide):
        if nucleotide == 'a' or nucleotide == 'A':
            self.a_count += 1
        elif nucleotide == 'c' or nucleotide == 'C':
            self.c_count += 1
        elif nucleotide == 'g' or nucleotide == 'G':
            self.g_count += 1
        else:
            self.t_count += 1

    def print_result(self):
        return str(self.m_length) + '\t' + str(self.a_count) + '\t' + str(self.c_count) + '\t' + str(self.g_count) + \
                '\t' + str(self.t_count) + '\n'

    def return_length(self):
        return self.m_length


# The function searches storage whether it contains Storage object for particular length
def search_storage(storage, length):
    for i in range(len(storage)):
        if storage[i].return_length() == length:
            return int(i)
    return -1


# The function returns length of the string without newline character at the end
def length_without_newline(text):
    if text[-1] == '\n':
        return len(text) - 1
    else:
        return len(text)


f_result = open(sys.argv[1][0:3] + '_count.txt', 'w')

storage_field = []

with open(sys.argv[1]) as input:
    for line in input:
        # if the line starts with '>' it is description and we can skip it
        if line[0] == '>':
            continue
        else:
            # if storage field doesn't contain the object for particular length it is added at the end.
            # therefore we need to add the nucleotide to the last object
            position = search_storage(storage_field, length_without_newline(line))
            if position == -1:
                storage_field.append(Storage(length_without_newline(line)))
                storage_field[len(storage_field) - 1].add(line[0])
            else:
                storage_field[position].add(line[0])

for i in range(len(storage_field)):
    f_result.write(storage_field[i].print_result())

f_result.close()
