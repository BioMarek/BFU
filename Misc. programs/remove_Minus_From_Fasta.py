# program removes all "-" from given file

with open('results/*.fasta', 'r') as inputFile, open('results/*.fasta bez pomlcek.fasta', 'w') as outputFile:
    data = inputFile.read()
    data = data.replace("-", "")
    outputFile.write(data)
