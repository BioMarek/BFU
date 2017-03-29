import pandas

processed_list = ['H11_B_CGATGT', 'H11_A_ATCACG', 'P1_A_CAGATC_', 'P1_B_ACTTGA_', 'P3_A_GATCAG_', 'P3_B_TAGCTT_',
                  'P8_A_TTAGGC_', 'P8_B_TGACCA_', 'REG_A_ACAGTG', 'REG_B_GCCAAT']

for processed_file in processed_list:
    f_result = open(processed_file + '_aligned_count.txt', 'w')
    sequences = []
    count = 0

    input = open(processed_file + '_aligned.bow', 'r')

    df = pandas.read_csv(input, delimiter='\t')

    for i in range(len(df)):
        # deals with problem with first zero
        if i == 0:
            sequences.append(df.iloc[i, 2])
            count += int(df.iloc[i, 0])
        else:
            if df.iloc[i, 2] not in sequences:
                sequences.append(df.iloc[i, 2])
                #result_to_write = str(df.iloc[i, 2]) + ' ' + str(count) + '\n'
                result_to_write = str(count) + '\n'
                f_result.write(result_to_write)
                count = 0
            else:
                count += int(df.iloc[i, 0])

    f_result.close()
