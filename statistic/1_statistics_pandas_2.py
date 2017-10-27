import pandas as pd


class BasicStatistics:
    def __init__(self):
        self.count_list = []
        self.name_list = ['H11_A', 'H11_B', 'P1_A_', 'P1_B_',  'P3_A_', 'P3_B_', 'P8_A_', 'P8_B_', 'REG_A', 'REG_B']  # TODO make dictionary
        self.sequence_stored = ''
        self.plant_typical = 0
        self.callus_typical = 0
        self.in_each_sample = 0

    def typical_for_plants(self):
        """"The function counts sequences that occur only in regenerated and parental plants"""
        if (sum(self.count_list[0:2]) == sum(self.count_list[8:10]) == 2) and not (sum(self.count_list[2:8]) == 6):  # TODO check correctness
            self.plant_typical = self.plant_typical = 1

    def typical_for_callus(self):
        """"The function counts sequences that occur only in callus passages"""
        if (sum(self.count_list[2:8]) == 6) and not (sum(self.count_list[0:2]) == sum(self.count_list[8:10]) == 2):   # TODO check correctness
            self.callus_typical = self.callus_typical = 1

    def occurs_in_each_sample(self):
        """"The function counts sequences that occur in all samples"""
        if sum(self.count_list) == 10:  # TODO check correctness
            self.in_each_sample = self.in_each_sample + 1

    def unique_df_length(self):
        pass

    def print_statistics(self, length):  # TODO add percentual stats
        print('sequences typical for plants (H11 and REG): ' + str(self.plant_typical) + str() + '%.')
        print('sequences typical for callus (P1, P3 and P8): ' + str(self.callus_typical) + str() + '%.')
        print('sequences that occur in all samples: ' + str(self.in_each_sample) + str() + '%.')

    def count(self, df):
        """"The function goes through dataframe and counts occurence of samples for each sequence"""
        for row in range(df):  # goes through each row in dataframe
            if df.iloc[row, 1] == self.sequence_stored:
                for i in range(len(self.name_list)):
                    if df.iloc[row, 0] == self.name_list[i]:
                        self.count_list[i] = self.count_list[i] + 1
                        break
            else:
                self.typical_for_plants()
                self.typical_for_callus()
                self.occurs_in_each_sample()
                self.sequence_stored = df.iloc[row, 1]
                self.count_list = [0 for i in range(10)]  # TODO check whether this is proper list reseting
        else:
            self.print_statistics(len(df))  # when the counting ends the final statistics is printed



df = pd.read_csv('collapsed_smRNA.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))
print('\n', df.shape)
print('\n', df.info())
