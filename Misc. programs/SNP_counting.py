with open('consensus.txt') as f:
    read_data = f.read()

nucleotides = ['A', 'C', 'G', 'T']
result = []
for i in range(len(read_data)):
    if i <= 100:
        window_start = 0
    else:
        window_start = i - 100

    count = 0
    for window in range(window_start, i + 1):
        if read_data[window] not in nucleotides:
            count += 1
    result.append(count)

print(*result, sep='\n')
f = open('result.txt', 'w')
f.write(str(result))
f.close()
