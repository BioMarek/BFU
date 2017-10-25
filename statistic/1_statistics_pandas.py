import pandas as pd


def basic_statistics(df):
    missing_in_sample = 0  # sequences that are missing in one of then samples
    in_all_samples = 0  # sequences that were found in all samples
    sequence_count = 1
    sequence_stored = df.iloc[0, 1]  # stores first sequence

    for row in range(1, len(df)):
        print('row:', row, 'seq tested:', df.iloc[row, 1], 'seq stored:', sequence_stored, 'seq count:', sequence_count,
              'ic count:', missing_in_sample, 'c count', in_all_samples)  # TODO
        if sequence_stored == df.iloc[row, 1]:
            sequence_count = sequence_count + 1
            if sequence_count == 10:
                in_all_samples = in_all_samples + 1
                sequence_count = 1
        else:
            missing_in_sample = missing_in_sample + 1
            sequence_count = 1
            sequence_stored = df.iloc[row, 1]
            continue

    return missing_in_sample, in_all_samples, len(df)


df = pd.read_csv('test.csv')
print(df.head(n=30))
#df.sort_values(by='sequence', inplace=True)
#print(df.head(n=30))
print('\n', df.shape)
print('\n', df.info())
a, b, c = basic_statistics(df)
print('\nmissing is: ', a, str(a / c * 100), '%, complete is: ', b, str(b * 10 / c * 100), '%, length is: ', str(c))

