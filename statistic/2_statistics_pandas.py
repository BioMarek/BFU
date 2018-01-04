import pandas as pd


class BasicStatistics:
    def __init__(self):
        self.count_list = []
        self.name_list = ['H11_A', 'H11_B', 'P1_A_', 'P1_B_', 'P3_A_', 'P3_B_', 'P8_A_', 'P8_B_', 'REG_A', 'REG_B']  # TODO make dictionary
        self.sequence_stored = ''
        self.unique_count = 0  # counts number of unique sequences
        self.size = 5  # number of biological replicates
        self.pattern_match_result = [0 for x in range(2 ** self.size)]  # generates list to store results from pattern matching

    def pattern_generator(self):
        """
        The function will generate all the possible combinations of samples
        :return: list of lists containing combinations
        """
        # TODO remove all false first combination
        binary_set = [0 for x in range(self.size)]
        final_set = []

        def calc(pow_set):
            for i in range(len(pow_set)):
                if binary_set[i] == 2:
                    binary_set[i] = 0
                    # protection from reaching out of index range
                    if i < len(binary_set) - 1:
                        binary_set[i + 1] += 1

        def convert(pow_set):
            converted_set = []
            for i in range(len(pow_set)):
                if pow_set[i] == 1:
                    converted_set.append(True)
                    converted_set.append(True)
                else:
                    converted_set.append(False)
                    converted_set.append(False)
            final_set.append(converted_set)

        for i in range(2 ** self.size):
            convert(binary_set)
            binary_set[0] += 1
            calc(binary_set)
        return final_set

    def match_to_pattern(self, pattern_list):
        """"The function counts number of unique sequences that occur only in regenerated and parental plants"""
        for pattern_row in range(len(pattern_list)):
            if self.count_list == pattern_list[pattern_row]:
                self.pattern_match_result[pattern_row] += 1
                break
                # TODO addition to pattern result storage

    def test_name_list(self, row):
        """The function saves information about name of sample in currently tested row"""
        for i in range(len(self.name_list)):
            if df.iloc[row, 0] == self.name_list[i]:
                self.count_list[i] += 1
                break

    def count(self, df):
        """"The function goes through dataframe and counts occurrence of sample for each sequence"""
        for row in range(len(df)):  # goes through each row in dataframe

            if row % 10000 == 0:  # TODO
                print('testing row: ', row, 'from: ', len(df))  # TODO
                #self.print_statistics()  # TODO

            if df.iloc[row, 1] == self.sequence_stored:
                self.test_name_list(row)
            else:
                # print(self.count_list, self.sequence_stored)  # TODO
                self.unique_count += 1
                self.match_to_pattern(self.pattern_generator())

                self.count_list = [0 for i in range(10)]  # list reset, when row = 0 it is also initialization
                self.sequence_stored = df.iloc[row, 1]  # sets currently tested sequence
                self.test_name_list(row)
        else:
            print(self.pattern_match_result)


df = pd.read_csv('collapsed_smRNA.csv')
#df = pd.read_csv('test.csv')
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))

x = BasicStatistics()
x.count(df)
