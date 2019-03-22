import csv
import math


"""
Calculates distance of points a and b in 3D space
"""
def calculateDistance(aCoordinates, bCoordinates):
    return math.sqrt((aCoordinates[0] - bCoordinates[0])**2 +
                     (aCoordinates[1] - bCoordinates[1])**2 +
                     (aCoordinates[2] - bCoordinates[2])**2)


with open('_test.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    reader = csv.reader(csv_file)

    phosphateRows = []
    next(reader)
    for row in reader:
        phosphateRows.append([float(row[8]), float(row[9]), float(row[10])])  # appends only phosphate1 coordinates

result = []
windowSize = 20
if len(phosphateRows) > windowSize:
    i = 0
    while len(phosphateRows) > windowSize + i:
        result.append(calculateDistance(phosphateRows[i], phosphateRows[i + windowSize]))
        #print(calculateDistance(phosphateRows[i], phosphateRows[i + windowSize]))
        i += 1

print(result)


