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
    final_result = ('>' + remove_enter(line) + ' smRNA Nicotiana tabacum\n' + line)
    f_result.write(final_result)

f_result.close()
f_input.close()
end = datetime.datetime.now()
print('Start time: ', start, '  End time: ', end, '  It took: ', end - start)
