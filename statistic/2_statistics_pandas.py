import pandas as pd


class BasicStatistics:
    def __init__(self):
        self.count_list = []
        self.name_list = ['H11_A', 'H11_B', 'P1_A_', 'P1_B_', 'P3_A_', 'P3_B_', 'P8_A_', 'P8_B_', 'REG_A', 'REG_B']
        self.sequence_stored = ''  # sequence which is currently being tested
        self.unique_count = 0  # counts number of unique sequences
        self.size = 5  # number of biological replicates
        self.pattern_match_result = [0 for x in range(2 ** self.size)]  # generates list to store results from pattern matching
        self.set_of_patterns = []

    def pattern_generator(self):
        """
        The function will generate all the possible combinations of samples. Each combination composed from pairs
        because we analyze technical duplicates.
        :return: list of lists containing combinations.
        """
        binary_set = [0 for x in range(self.size)]
        final_set = []
        
        """
        The function checks sequence after addition of 1 if there is 2 it adds 1 to higher order.
        """
        def calculate(sequence):
            for i in range(len(sequence)):
                if binary_set[i] == 2:
                    binary_set[i] = 0
                    # protection from reaching out of index range
                    if i < len(binary_set) - 1:
                        binary_set[i + 1] += 1

        """
        The function converts each number in sequence into two same numbers.
        """
        def convert(sequence):
            converted_set = []
            for i in range(len(sequence)):
                if sequence[i] == 1:
                    converted_set.append(1)
                    converted_set.append(1)
                else:
                    converted_set.append(0)
                    converted_set.append(0)
            final_set.append(converted_set)

        for i in range(2 ** self.size):
            convert(binary_set)
            binary_set[0] += 1
            calculate(binary_set)
            
        self.set_of_patterns = final_set  # saves pattern set so we can use in result presentation

    def match_to_pattern(self, pattern_list):
        """"The function """
        for pattern_row in range(len(pattern_list)):
            if self.count_list == pattern_list[pattern_row]:
                self.pattern_match_result[pattern_row] += 1
                break

    def test_name_list(self, row):
        """The function saves information about name of sample in currently tested row"""
        for i in range(len(self.name_list)):
            if df.iloc[row, 0] == self.name_list[i]:
                self.count_list[i] += 1
                break

    def count(self, df):
        """"The function goes through dataframe and counts occurrence of sample for each sequence"""
        self.pattern_generator()
        
        for row in range(len(df)):  # goes through each row in dataframe

            if row % 10000 == 0:  # TODO
                print('testing row: ', row, 'from: ', len(df))  # TODO
                #self.print_statistics()  # TODO

            if df.iloc[row, 1] == self.sequence_stored:
                self.test_name_list(row)
            else:
                # print(self.count_list, self.sequence_stored)  # TODO
                self.unique_count += 1
                self.match_to_pattern(self.set_of_patterns)

                self.count_list = [0 for i in range(10)]  # list reset, when row = 0 it is also initialization
                self.sequence_stored = df.iloc[row, 1]  # sets currently tested sequence
                self.test_name_list(row)
        else:
            result_file = open('statistics_result.txt', 'w')
            for i in range(len(self.set_of_patterns)):
                print(str(self.set_of_patterns[i]) + ' : ' + str(self.pattern_match_result[i]) + '\n')
                result_file.write(str(self.set_of_patterns[i]) + ' : ' + str(self.pattern_match_result[i]) + '\n')

            result_file.close()


df = pd.read_csv('collapsed_smRNA.csv')
#df = pd.read_csv('test.csv')  # TODO
print(df.head(n=30))
df.sort_values(by='sequence', inplace=True)
print(df.head(n=30))

x = BasicStatistics()
x.count(df)
