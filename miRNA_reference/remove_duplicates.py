#######################################################################################################################
###INFORMATION ABOUT THE SCRIPT###
# The scritpt opens file with miRNAs sequences and removes duplicetes. The first occurence of each sequence and its 
# respective name is kept. This is because of inconsistent naming of plant Nicotiana tabacum miRNAs - there is several 
# miRNAs with same sequence but  different names. Works for miRBase format.

#######################################################################################################################
###SCRIPT BODY###
from Bio import SeqIO

f_result = open("Nicotiana_miRNA_D_no_duplicates.fa", 'w')  # file to witch we copy filtered sequences 
sequences = []  # temporary list used to store sequences already written into f_result file

for seq_record in SeqIO.parse("Nicotiana_miRNA_D.fa", "fasta"):
    if seq_record.seq not in sequences:
        sequences.append(seq_record.seq)
        # for some reason description is parsed without '>' character therefore it must be added
        final_result = '>' + seq_record.description + '\n' + seq_record.seq + '\n'
        f_result.write(str(final_result))

print("Number of sequences tah pased filter:" + len(sequences))
f_result.close()
