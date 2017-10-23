import pandas as pd

df = pd.read_csv('collapsed_smRNA.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))
