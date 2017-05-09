#! /bin/bash
#
PROJECT_DIR=/storage/brno7-cerit/home/marek_bfu/smRNA # path to project dir
INPUT_DIR=$PROJECT_DIR/aligned # path to input sequences and reference
OUTPUT_DIR=$PROJECT_DIR/bow_counts

mkdir $OUTPUT_DIR
cd $INPUT_DIR

module add python26-modules-gcc
module add python26-modules-intel

# runs python script
python -c
'
import pandas

processed_list = ['H11_A_ATCACG', 'H11_B_CGATGT','P1_A_CAGATC_', 'P1_B_ACTTGA_', 'P3_A_GATCAG_', 'P3_B_TAGCTT_',
                  'P8_A_TTAGGC_', 'P8_B_TGACCA_', 'REG_A_ACAGTG', 'REG_B_GCCAAT']

#processed_list = ['H11_A_ATCACG'] # switch comments to get first column wit names of sequences
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
                if processed_file == 'H11_A_ATCACG':
                    result_to_write = str(df.iloc[i, 2]) + ' ' + str(count) + '\n'
                else:
                    result_to_write = str(count) + '\n'
                f_result.write(result_to_write)
                count = 0
            else:
                count += int(df.iloc[i, 0])
    f_result.close()
'

mv *_aligned.bow $OUTPUT_DIR
