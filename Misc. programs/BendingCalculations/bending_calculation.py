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

    phosphateRows =[]
    for row in reader:
        phosphateRows.append(row[8:14])
        print(row[0], row[8:14])
        #print(row)

phosphateRows = phosphateRows[1:]
print(phosphateRows)

print(calculateDistance([-69.36834, 9.17868, -24.17384], [-71.78425, 7.23292, -19.04525]))


