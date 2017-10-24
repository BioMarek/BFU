import pandas as pd


def basic_statistics(df):
    missing_in_sample = 0  # sequences that are missing in one of then samples
    in_all_samples = 0  # sequences that were found in all samples
    sequence_count = 0
    sequence_stored = ''  # stores currently counted sequenc
    for row in range(len(df)):
        sequence_count = 0
        sequence_stored = ''  # stores currently counted sequence

        if sequence_count == 0:
            sequence_stored = df.iloc[row, 1]
            sequence_count = 1
            continue

        if sequence_stored == df.iloc[row, 1]:
            sequence_count = sequence_count + 1
        else:
            if sequence_count == 10:
                in_all_samples = in_all_samples + 1
            else:
                missing_in_sample = missing_in_sample + 1
            sequence_count = 0
            continue

    return missing_in_sample, in_all_samples, len(df)


df = pd.read_csv('collapsed_smRNA.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))
print(df.shape)
print(df.info())
a, b, c = basic_statistics(df)
print('missing is: ', a, str(a/c), '%, complete is: ', b, str(b/c), '%.')

