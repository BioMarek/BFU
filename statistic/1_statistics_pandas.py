import pandas as pd


def basic_statistics(df):
    in_all_samples = 0  # sequences that were found in all samples
    sequence_count = 1
    sequence_stored = df.iloc[0, 1]  # stores first sequence

    for row in range(0, len(df)):
        print('row:', row, 'seq tested:', df.iloc[row, 1], 'seq stored:', sequence_stored, 'seq count:', sequence_count, 'c count', in_all_samples)  # TODO
        if sequence_stored == df.iloc[row, 1]:
            sequence_count = sequence_count + 1
            if sequence_count == 10:
                in_all_samples = in_all_samples + 1
                sequence_count = 1
        else:
            sequence_count = 1
            sequence_stored = df.iloc[row, 1]

    return in_all_samples, len(df)


df = pd.read_csv('test.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))
print('\n', df.shape)
print('\n', df.info())
a, b = basic_statistics(df)
print('\nmissing is: ', b - a * 10, str(100 / b * (b - a * 10)), '%, complete is: ', a, str(a * 10 / b * 100), '%, length is: ', str(b))

