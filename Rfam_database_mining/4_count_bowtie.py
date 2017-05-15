# TODO it doesn't work!!

#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
## SCRIPT INPUT  *.bow files from bowtie
## SCRIPT OUTPUT *.counts files
# The script takes alignment files from bowtie and creates counts for each file. These files are in subsequent step 
# merged to create count matrix.

#######################################################################################################################
###SCRIPT BODY###
import pandas

processed_list = ['H11_A_ATCACG', 'H11_B_CGATGT','P1_A_CAGATC_', 'P1_B_ACTTGA_', 'P3_A_GATCAG_', 'P3_B_TAGCTT_',
                  'P8_A_TTAGGC_', 'P8_B_TGACCA_', 'REG_A_ACAGTG', 'REG_B_GCCAAT']

for processed_file in processed_list:
    f_result = open(processed_file + '_aligned.counts', 'w')
    sequences = []
    count = 0

    input_file = open(processed_file + '_aligned.bow', 'r')

    df = pandas.read_csv(input_file, delimiter='\t')

    for i in range(len(df)):
        # deals with problem with first zero
        if i == 0:
            # iloc takes specific field in matrix
            sequences.append(df.iloc[i, 2])
            count += int(df.iloc[i, 0])
        else:
            if df.iloc[i, 2] not in sequences:
                sequences.append(df.iloc[i, 2])
                if processed_file == 'H11_A_ATCACG': # if the first file is processed we want names of sequences in first column
                    result_to_write = str(df.iloc[i, 2]) + ' ' + str(count) + '\n'
                else:
                    result_to_write = str(count) + '\n'
                f_result.write(result_to_write)
                count = 0
            else:
                count += int(df.iloc[i, 0])
    f_result.close()
