import pandas as pd


class BasicStatistics:
    def __init__(self):
        self.count_list = []
        self.name_list = ['H11_A', 'H11_B', 'P1_A_', 'P1_B_',  'P3_A_', 'P3_B_', 'P8_A_', 'P8_B_', 'REG_A', 'REG_B']  # TODO make dictionary
        self.sequence_stored = ''

        self.plant_typical = 0  # number of sequences that are typical only for parental and regenerated plants
        self.callus_typical = 0  # number of sequences that are typical only for callus passages
        self.in_each_sample = 0  # number of sequences that can be found in all samples
        self.dedifferentiation_typical = 0  # number of sequences that are typical for dedifferentiation
        self.regeneration_typical = 0  # number of sequences that are typical for regeneration
        self.parental_plant_typical = 0  # number of sequences that are typical for plant
        self.first_replicate = 0  # number of sequences that are typical for first technical replicate
        self.second_replicate = 0  # number of sequences that are typical for second technical replicate
        self.before_change = 0  # number of sequences that are typical before dediff. and reg.
        self.after_change = 0  # number of sequences that are typical after dediff. and reg.

    def typical_for_plants(self):
        """"The function counts number of unique sequences that occur only in regenerated and parental plants"""
        if self.count_list == [True, True, False, False, False, False, False, False, True, True]:  # TODO check correctness make faster
            self.plant_typical = self.plant_typical = 1

    def typical_for_callus(self):
        """"The function counts number of unique sequences that occur only in callus passages"""
        if self.count_list == [False, False, True, True, True, True, True, True, False, False]:   # TODO check correctness make faster
            self.callus_typical = self.callus_typical = 1

    def typical_in_each_sample(self):
        """"The function counts number of unique sequences that occur in all samples"""
        if self.count_list == [True, True, True, True, True, True, True, True, True, True]:  # TODO check correctness make faster
            self.in_each_sample = self.in_each_sample + 1

    def typical_for_dedifferentiation(self):
        """"The function counts sequences that occurs only in first passage"""
        if self.count_list == [False, False, True, True, False, False, False, False, False, False]:  # TODO check correctness make faster
            self.dedifferentiation_typical = self.dedifferentiation_typical + 1

    def typical_for_regeneration(self):
        """"The function counts sequences that occurs only in regenerated plants"""
        if self.count_list == [False, False, False, False, False, False, False, False, True, True]:  # TODO check correctness make faster
            self.regeneration_typical = self.regeneration_typical + 1

    def typical_for_parental_plant(self):
        """The function counts sequences that occurs only in parental plants"""
        if self.count_list == [True, True, False, False, False, False, False, False, False, False]:  # TODO check correctness make faster
            self.parental_plant_typical = self.parental_plant_typical + 1
            
    def typical_for_first_replicate(self):
        """The function counts sequences that occurs only in first technical replicate"""
        if self.count_list == [True, False, True, False, True, False, True, False, True, False]:  # TODO check correctness make faster
            self.first_replicate = self.first_replicate + 1
        
    def typical_for_second_replicate(self):
        """The function counts sequences that occurs only in second technical replicate"""
        if self.count_list == [False, True, False, True, False, True, False, True, False, True]:  # TODO check correctness make faster
            self.second_replicate = self.second_replicate + 1

    def typical_before_change(self):
        """The function counts sequences that occurs only before hormonal treatment"""
        if self.count_list == [True, True, False, False, False, False, True, True, False, False]:  # TODO check correctness make faster
            self.before_change = self.before_change + 1

    def typical_after_change(self):
        """The function counts sequences that occurs only after hormonal treatment"""
        if self.count_list == [False, False, True, True, False, False, False, False, True, True]:  # TODO check correctness make faster
            self.after_change = self.after_change + 1
            
    def unique_df_length(self):
        pass

    def test_name_list(self, row):
        """The function saves information about name of sample in currently tested row"""
        for i in range(len(self.name_list)):
            if df.iloc[row, 0] == self.name_list[i]:
                self.count_list[i] = self.count_list[i] + 1
                break

    def print_statistics(self, length):  # TODO add percentual stats
        print('sequences typical for plants (H11 and REG): ' + str(self.plant_typical) + '. ' + str() + '%.')
        print('sequences typical for callus (P1, P3 and P8): ' + str(self.callus_typical) + '. ' + str() + '%.')
        print('sequences that occur in all samples: ' + str(self.in_each_sample) + '. ' + str() + '%.')
        print('sequences that occur during dedifferentiation (P1): ' + str(self.dedifferentiation_typical) + '. ' + str() + '%.')
        print('sequences that occur during regeneration (REG): ' + str(self.regeneration_typical) + '. ' + str() + '%.')
        print('sequences typical only for parental plants (H11): ' + str(self.parental_plant_typical) + '. ' + str() + '%.')
        

    def count(self, df):
        """"The function goes through dataframe and counts occurrence of sample for each sequence"""
        for row in range(len(df)):  # goes through each row in dataframe

            if row % 10000 == 0:  # TODO
                print('testing row: ', row)  # TODO

            if df.iloc[row, 1] == self.sequence_stored:
                self.test_name_list(row)
            else:
                # print(self.count_list)  # TODO
                self.typical_for_plants()
                self.typical_for_callus()
                self.typical_in_each_sample()
                self.typical_for_dedifferentiation()
                self.typical_for_regeneration()
                self.typical_for_parental_plant()

                self.count_list = [0 for i in range(10)]  # list reset, when row = 0 it is also initialization
                self.sequence_stored = df.iloc[row, 1]  # sets currently tested sequence
                self.test_name_list(row)
        else:
            self.print_statistics(len(df))  # when the counting ends the final statistics is printed



df = pd.read_csv('test.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))
print('\n', df.shape)
print('\n', df.info())

x = BasicStatistics()
x.count(df)
