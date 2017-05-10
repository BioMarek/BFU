from Bio import SeqIO

# The script removes duplicates from fasta file
f_result = open("Nicotiana_Rfam_seq_no_duplicates.fa", 'w')

sequences = []
for seq_record in SeqIO.parse("Nicotiana_Rfam_seq.fa", "fasta"):
    print(seq_record.seq)
    if seq_record.seq not in sequences:
        sequences.append(seq_record.seq)
        final_result = (">" +seq_record.description + '\n' + seq_record.seq + '\n')


print(len(sequences))
f_result.close()
