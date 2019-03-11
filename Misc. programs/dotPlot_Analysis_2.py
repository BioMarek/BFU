'''
working dot plot that sorts sequences
'''

from Bio import SeqIO
from Bio.Alphabet import IUPAC
from Bio.Seq import Seq
import matplotlib.pyplot as plt
import datetime

start = datetime.datetime.now()
print('Start time: ', start)


def sequence_id_fun(sequence):
    # function extracts unique id from unnecessarily long id that each sequence has
    sequence = sequence[62:]
    new_id = ''
    for i in range(len(sequence)):
        if sequence[i] != '/':
            new_id += sequence[i]
        else:
            break
    return new_id


def calculation(my_seq):
    # there is no graph drawing therefore we don't need y axis
    window = 9
    dict = {}
    dict_str = {}
    dict_rev_com = {}
    dict_com = {}
    dict_rev = {}
    x_axis_tandem = 0
    x_axis_reverse_complement = 0
    # x_axis_complement = 0
    # x_axis_reverse = 0
    # lists are no longer necessary if we don't draw plots

    for i in range(len(my_seq) - window):
        # creates windows from given sequence size 9 seemed best based on visual observation
        dict[i] = my_seq[i:i+window+1]

    lll = len(dict)
    # creating new variable lll is little bit faster

    for i in range(lll):
        # optimization, converting dicts to string first and then comparing them in the for loop below, 31x faster
        dict_str[i] = str(dict[i])
        dict_rev_com[i] = str(dict[i].reverse_complement())
        # dict_com[i] = str(dict[i].complement())
        # dict_rev[i] = str(dict[i].reverse_complement().complement())

    for i in range(lll):
        # comparison of windows with themselves
        for ii in range(lll):
            if dict_str[i] == dict_str[ii]:
                x_axis_tandem += 1
            if dict_str[i] == dict_rev_com[ii]:
                x_axis_reverse_complement += 1

            # # i have yet to find biological significance for these two
            # if dict_str[i] == dict_com[ii]:
            #     x_axis_complement += 1
            # if dict_str[i] == dict_rev[ii]:
            #     x_axis_reverse += 1
            if ii + 1 == i:
                # optimization: removes bottom half of the graph under diagonal (and diagonal hence " + 1"), because it
                # is redundant information, 2x faster
                break
    return x_axis_tandem / lll, x_axis_reverse_complement / lll\
        # , x_axis_complement / lll, x_axis_reverse / lll
    # returning count divided by length of sequence as a compensation

seq_counter = 0
f = open('result_4.txt', 'w')
for seq_record in SeqIO.parse("NG4.fasta", "fasta"):
    sequence_id = seq_record.id
    my_sequence = seq_record.seq

    x = sequence_id_fun(sequence_id)
    # y, z, p, q = calculation(my_sequence)
    y, z = calculation(my_sequence)
    seq_counter += 1
    # counter is here just for information, it tells us rank of sequence
    # final_result = ('sequence ' + str(seq_counter) + ',' + str(x) + ',' + str(y) + ',' + str(z) + ',' + str(p) + ','
    #                 + str(q) + '\n')
    final_result = ('sequence ' + str(seq_counter) + ',' + str(x) + ',' + str(y) + ',' + str(z) + ',' + '\n')
    print(final_result)
    f.write(final_result)

f.close()
end = datetime.datetime.now()
print('Start time: ', start, '  End time: ', end, '  It took: ', end - start)


''' working dot plot that draws picture'''


# from Bio import SeqIO
# from Bio.Alphabet import IUPAC
# from Bio.Seq import Seq
# import matplotlib.pyplot as plt
#
#
# word = 9
# my_seq = Seq("GGTTTCTAGGGTTCCTTAAATGAGTGATTTTTATTTTTATCGTTTGAATTTCACTCGTTTAACTGTCATCATAGCTTACGGGGCTGTAAAATTGTTGCGTCTGTCTGATTCCATTCATGTTTTCGCTACATTTGACTATCTACGGGAGTTGGCTAGGAATGTCGGGAATTGAGAATTTAGATGAAAAGAATTCAAAGCTGATCTGGTTCAACCGACCGATAGTTCTGATTTCGAAGTTGAGCATTTGCATTTTAGTGCAGACCTCAATCATGTCAATATTGGATGTCTGTATGCACTTCAGTTTGTGTGCAGTCATCTTTCGGTCGTTTGGTGTTCATTAGATGGCCATATGAGGGGGAATGTCACTGGATGTCTTTCCATACAATGCTGATTCATTCCTTAGAGGATATTCAGGATTGATATATTGTCTGAAGGAATCAATAAATTTGTGTTATCTAGTCTTTATGGAGCAGATGATTAGCTCATGAATGTGATTTATGCATTGAATTTGACAACTAGGAAACAATTAAGAACATGTCAATGCTTACAGATAGACCATTCTCATTGGGGCTGAGAATGATGAATGATTGGTTATGTAGTAAGGCGATGCGGGCATCATTTGATTCATTTTGTTTGTCTATTAAGATACTGGAGCCTCTTTCTTTATGAGTTCTGCAGATAATTATCATGAGTTCATCTGAATTTCATTCTGTAGATTCTCATTTCTCTGACATCAACCAGCTGTCGCAACTACTGCAGACATGAGTTTTGTTTTCCGTGGAACAAGAGTTCCAGACATAGAAAATGGTCTATCTGGATTTATACCTGAACGGCGTGCAATGTATGCTCAATATTTTACACTCTCGACTTGTTAACACCAATACTTGAAAATTTATAGAACCTGCACTTCTCATGATCTTAATTTAAAATATATGGTTTTTCTGCTCCCAATCAGCGGGTTCATGCAGCACGTCCTGTTAACTCAAACTCACTTGCCTTTCTTGTCACAGGTACCATTTCACCTATATACAGACTAATATCTGTTTCATGTGATAATTTTGATCTATTGCATTGTTTTAACTCCTTGACCTTGTTGCAGTCCTTCTGTTGTTCATGATGTTAAATTCTCACCAGATGTCACCGAACTTTCTGGTAAGTTTTACATTTCACACTGGATGAGCAGTAGACTGGTGTTACTCTACCCTTGATGCAAATCTTTACATTTCTTCCTTTGAACATGCATATTTAGCTCTGGCTTGTGCTTGGTGTGTTTTTGATGGCTACAACATTAAGGATGTATGCGACCTGTCAACAACTTCAGGCTCAAGCCCAATCTAGAGCTATGGCAGCCAGTGGCCTTCTTGGGCACACTGAATTGAGGTTACATATGCCACCATCAATAGCACTTGCTACTAGAGGGCGTTTACAAGGGCTAAGGCTTCAACTTGCTCTGCTTGATCGGGAATTTGATGATTTAGGTATGGTTCAAATCTAAAAAGTTTAAGTTCGTTGTTTCTTGTAAAAGTTTTTTATGGATGATAATGTAGTAACATATTGTTTATCTTCAGATTATGAAACTTTGAGAGCTTTGGATTCTGACAATGCTCCGACAACACCTTCTATGAGTGAGGAACAAATAAATGCTCTTCCTGTTCATAAATACAAGGTTTCTGTTCCTCAAAGGTAATCAGCCCCATACTGTCTACAGTCCAGAAAGAATTAGGGTATCTGTTGCCTTATTCTAAGATTTGCTTGGAAGACTCATATTCTCTGGTGAAAGATTTTTCAACGATGAAATCCATGTACTTGAGCTTGCACTCATAAACTAAAGTAACGTTTTCATTAAATTATCTACAGCGACCCCTCTGTGAACCAGCAGGCTTCCTCGAAAAATACAAGAGGATGATTGGCATGACATATGGTAGGAGCATTCAAGTTTATGAGGGAGTTATGTTGCAAATAAACGTAAATGAGAAAAAAAAAAAAAGAGAAAGAAGCAGTAATTAATTTTGGTTTTTAATTTAGTAAAAAAGGGATATGTATTTTAGGGAAGGAGTGACTTATGGGTGAGAAAACGTGGGATAGTTATGGGTGACTTATAAGCTTTACCTCTCTTTCTAATGTCAGAGCAAGAGAAAGCAGAGCAAAAAAGGTTGCAGAACAAAGTGTAATAGAAAAAGACTTTTGAGAATTCTTTGTCTCCTTGTCTCTCCTCTCTCGACACCCCTTCACAGTTTCGTGAGAGTTATCTAAACAAGTTAGTTTCAGAGCGAGCGTCCATTTTCTACACGTCAGTATCAGAGAAAATTTATTTTCTACAAATTGGTATCGGAGCGGCTTTTAATTTTAACAATGCGGTGAGGGGATGGAACGTTGTATGTATAATGCCATGGAGGTAAATCTTAAGGACCTCATGCACGCTATGTGTTATGTACACGGGGGTTACTTTCCCGATATGTTGATGATGGTATGGACGTGTACGTT")
#
# dict = {}
# dict_str = {}
# dict_rev_com = {}
# dict_com = {}
# dict_rev = {}
# x_axis_tandem = []
# y_axis_tandem = []
# x_axis_complement = []
# y_axis_complement = []
# x_axis_reverse = []
# y_axis_reverse = []
# x_axis_reverse_complement = []
# y_axis_reverse_complement = []
#
# for i in range(len(my_seq) - word):
#     dict[i] = my_seq[i:i+word+1]
#
# lll = len(dict)
# # creating new variable lll is little bit faster
#
# for i in range(lll):
#     # optimization, converting dicts to string first and then comparing them in the for loop below, 31x faster
#     dict_str[i] = str(dict[i])
#     dict_rev_com[i] = str(dict[i].reverse_complement())
#     dict_com[i] = str(dict[i].complement())
#     dict_rev[i] = str(dict[i].reverse_complement().complement())
#
# for i in range(lll):
#     if i % 100 == 0:
#         print(i, "cycle")
#     for ii in range(lll):
#         if dict_str[i] == dict_str[ii]:
#             x_axis_tandem.append(i)
#             y_axis_tandem.append(ii)
#         if dict_str[i] == dict_rev_com[ii]:
#             x_axis_reverse_complement.append(i)
#             y_axis_reverse_complement.append(ii)
#
#         # i have yet to find biological significance for these two
#         if dict_str[i] == dict_com[ii]:
#             x_axis_complement.append(i)
#             y_axis_complement.append(ii)
#         if dict_str[i] == dict_rev[ii]:
#             x_axis_reverse.append(i)
#             y_axis_reverse.append(ii)
#
#
# fig = plt.figure()
# ax1 = fig.add_subplot(111)
# ax1.scatter(x_axis_tandem, y_axis_tandem, c="r", marker=',', edgecolor='none', label="Tandem repeat")
# ax1.scatter(x_axis_reverse_complement, y_axis_reverse_complement, c="c", marker=',', edgecolor='none', label="Reverse complement")
# ax1.scatter(x_axis_complement, y_axis_complement, c="k", marker=',', edgecolor='none', label="Complement")
# ax1.scatter(x_axis_reverse, y_axis_reverse, c="b", marker=',', edgecolor='none', label="Reverse")
# plt.gca().invert_yaxis()
# plt.legend()
# plt.show()

''' '''

