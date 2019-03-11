# program removes all "-" from given file

with open('*.fasta', 'r') as inputFile, open('*.fasta bez pomlcek.fasta', 'w') as outputFile:
    data = inputFile.read()
    data = data.replace("-", "")
    outputFile.write(data)
