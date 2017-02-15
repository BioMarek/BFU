from Bio import SeqIO
import datetime

start = datetime.datetime.now()
print('Start time: ', start)

processed_file = 'H11_A_ATCACG'
f_result = open(processed_file + "_r.txt", 'w')

for seq_record in SeqIO.parse("Nicotiana_miRNA_D.fa", "fasta"):
    # print(seq_record.id, seq_record.seq)

    f_input = open(processed_file + ".txt", 'r')
    for line in f_input:
        # splits the input file using space as separator, first column is number of sequences, second column is
        # sequence itself, I have the input file prepared in correct format
        sequence = line.split()
        if sequence[1] == seq_record.seq:
            # I use final result variable because I want to print it on screen and into file
            final_result = (seq_record.id + ',' + sequence[0] + '\n')
            print(final_result)
            f_result.write(final_result)
            break
    # for-else design, very useful, if there is no sequence found and end of file is reached we can print 0
    else:
        final_result = (seq_record.id + ',0\n')
        print(final_result)
        f_result.write(final_result)


f_result.close()
f_input.close()

end = datetime.datetime.now()
print('Start time: ', start, '  End time: ', end, '  It took: ', end - start)