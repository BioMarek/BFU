#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# The script takes preprocessed sequencing file (see pipeline) and creates count matrix for DESeq2 analysis. Commonly
# used tools designed to do this have difficulties to process data from Nicotiana tabacum or plants in general.

#######################################################################################################################
###SCRIPT BODY###
from Bio import SeqIO
# import datetime

# start = datetime.datetime.now()
# print('Start time: ', start)

processed_list = ['H11_B_CGATGT', 'H11_A_ATCACG', 'P1_A_CAGATC_', 'P1_B_ACTTGA_', 'P3_A_GATCAG_', 'P3_B_TAGCTT_',
                  'P8_A_TTAGGC_', 'P8_B_TGACCA_', 'REG_A_ACAGTG', 'REG_B_GCCAAT']

for processed_file in processed_list:
    f_result = open(processed_file + '_temp.counts', 'w')
    f_result.write(processed_file + '\n')  # inserts name of processed sample
    f_input = open(processed_file + '.txt', 'r')

    for seq_record in SeqIO.parse('Nicotiana_miRNA_D.fa', 'fasta'):
        f_result.write(str('NEW ' + seq_record.seq))
        for line in f_input:
            # splits the input file using space as separator, first column is number of sequences, second column is
            # sequence itself, I have the input file prepared in correct format
            sequence = line.split()
            f_result.write(str('sequence: ' + sequence[1] + ' reference: ' + seq_record.seq + '\n'))
            if sequence[1] == seq_record.seq:
                # I use final result variable because I want to print it on screen and into file, also it has to be string
                # to write it in file
                final_result = seq_record.id + ',' + sequence[0] + '\n'
                # print(final_result)  # INFO
                f_result.write('\n\n HIT' + final_result)
                break
        # for-else design, very useful, if there is no sequence found and end of file is reached we can print 0
        else:
            final_result = (seq_record.id + ',0\n')
            # print(final_result)  # INFO
            f_result.write(final_result)

    f_result.close()
    f_input.close()

# end = datetime.datetime.now()
# print('Start time: ', start, '  End time: ', end, '  It took: ', end - start)
