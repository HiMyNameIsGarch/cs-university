# Given the current date (day, month, year) and the birthdate of a person (day,
# month, year) compute the age of the person in number of years.
# e.g. If the current date is 4.3.2002 and the person birthdate is 5.9.1980 than the person is 21
# years old.
date = list(input("date: ").split("."))
y = int(date[2])
d = int(date[1])
m = int(date[0])
cy = 2002; cm = 3; cd = 4
age = cy - y - ((cm, cd) < (m, d))
print(age)
