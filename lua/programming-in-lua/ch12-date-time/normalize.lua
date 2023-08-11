t = os.date("*t")
print(t.day, t.month) --> 11 8
t.day = t.day - 40
print(t.day, t.month) --> -29 8
t = os.date("*t", os.time(t))
print(t.day, t.month) --> 2 7

t = os.date("*t")
print(os.date("%Y/%m/%d", os.time(t))) -- 2023/08/11
t.month = t.month + 6
print(os.date("%Y/%m/%d", os.time(t))) -- 2024/02/11