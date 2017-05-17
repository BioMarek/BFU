import pandas
import sys

# list of files with sequences from which the reference will be made
processed_list = ['H11_A_ATCACG', 'H11_B_CGATGT', 'P1_A_CAGATC_', 'P1_B_ACTTGA_', 'P3_A_GATCAG_', 'P3_B_TAGCTT_',
                  'P8_A_TTAGGC_', 'P8_B_TGACCA_', 'REG_A_ACAGTG', 'REG_B_GCCAAT']

# creates reference list with names of sequences
sequences = []
for processed_file in processed_list:
    input_file = open(processed_file + '_aligned.bow', 'r')
    df = pandas.read_csv(input_file, delimiter='\t')

    for i in range(len(df)):
        if df.iloc[i, 2] not in sequences:
            sequences.append(df.iloc[i, 2])

    input_file.close()

# creates count matrix for file given in argument
processed_file = str(sys.argv[1])
f_result = open(processed_file + '_aligned.counts', 'w')
input_file = open(processed_file + '_aligned.bow', 'r')
df = pandas.read_csv(input_file, delimiter='\t')

# goes through each sequence in reference list
for seq in range(len(sequences)):
    count = 0
    # goes through each line in processed_file and compares with analyzed sequence
    flag = 0  # flag that tells us that we are currently in block of sequences that are being counted
    for i in range(len(df)):
        if df.iloc[i, 2] == sequences[seq]:
            flag = 1
            count += int(df.iloc[i, 0])
        # if we are in the block of sequence which are being sounted (flag == 1) but the name of sequence changed we are
        # we at the next sequence and we need to start counting the next sequence
        if (df.iloc[i, 2] != sequences[seq]) and flag == 1:
            break
    # for more convenient merging the first counted file will have names of sequences in the first column
    if processed_file == 'H11_A_ATCACG':
        result_to_write = sequences[seq] + ' ' + str(count) + '\n'
    else:
        result_to_write = str(count) + '\n'

    f_result.write(result_to_write)

input_file.close()
f_result.close()
