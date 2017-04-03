import pandas

input_file = open('frnadb_summary.csv', 'r')
df = pandas.read_csv(input_file, delimiter=',')

# appending to original reference file of noncoding RNAs, then no duplicates has to be run
f_result = open("Nicotiana_Rfam_seq.fa", 'a')

# takes relevant information from frnadb downloadad database
for i in range(len(df)):
    final_result = ('>' + df.iloc[i, 0] + '_' + df.iloc[i, 2] + '\n' + df.iloc[i, 7] + '\n')
    f_result.write(str(final_result))

f_result.close()
