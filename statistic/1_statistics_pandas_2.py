import pandas as pd


class BasicStatistics:
    def __init__(self):
        self.count_list = []
        self.name_list = ['H11_A', 'H11_B', 'P1_A_', 'P1_B_',  'P3_A_', 'P3_B_', 'P8_A_', 'P8_B_', 'REG_A', 'REG_B']
        self.sequence_stored = ''

    def count(self, df):
        for row in range(df):
            if df.iloc[row, 1] == self.sequence_stored:
                for i in range(len(self.name_list)):
                    if df.iloc[row, 0] == self.name_list[i]:
                        self.count_list[i] = self.count_list[i] + 1
                        break
            else:
                # TODO call various statistics functions
                self.sequence_stored = df.iloc[row, 1]
                self.count_list = [0 for i in range(10)]  # TODO check whether this is proper list reseting



df = pd.read_csv('collapsed_smRNA.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))
print('\n', df.shape)
print('\n', df.info())
