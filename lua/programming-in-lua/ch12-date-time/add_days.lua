t = os.date("*t")
print(os.date("%Y/%m/%d", os.time(t))) --> 2023/08/11

t.day = t.day + 40
print(os.date("%Y/%m/%d", os.time(t))) --> 2023/09/20