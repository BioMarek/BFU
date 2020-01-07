import matplotlib.pyplot as plt

data = [1, 2, 3, 8, 9, 5, 6, 4, 12]
plt.boxplot(data)
plt.savefig("boxplot.pdf")
plt.show()
