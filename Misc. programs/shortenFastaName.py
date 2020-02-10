inputPath = 'c:\Programing\Python\sequences.fasta'
outputPath = 'c:\Programing\Python\sequencesR.fasta'

prefixToDelete = 'A00721:127:HW5KYDSXX:4:'
suffixToDelete = '_1:N:0:GGTCTGGT+AAGGCCGT'

with open(inputPath, 'r') as inputFile, open(outputPath, 'w') as outputFile:
    line = inputFile.readline()
    while line:

        if line[0] == '>':
            leftIndex = line.find(prefixToDelete) + len(prefixToDelete)
            rightIndex = len(line) - line.find(suffixToDelete)

            if leftIndex > 0 and len(prefixToDelete) > 0:
                line = line[leftIndex:]
            if rightIndex > 0 and len(suffixToDelete) > 0:
                line = line[:-rightIndex]
            line = '>' + line + '\n'

        outputFile.write(line)
        line = inputFile.readline()
