# Determine a date (as day, month, year) starting from two integer numbers that
# represent the year and the number of the day in that year.
# e.g.
# Input
#   year = 2004
#   days = 68
# Output
#   8.03.2004
y = int(input("year: "))
d = int(input("days: "))
m = d // 30
d = d % 30
if m != 0: m+=1
if m < 10: m = "0" + str(m)
print(f"{d}.{m}.{y}")

