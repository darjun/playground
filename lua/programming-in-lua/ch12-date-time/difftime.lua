local t5_3 = os.time({year=2015, month=1, day=12})
local t5_2 = os.time({year=2011, month=12, day=16})
local d = os.difftime(t5_3, t5_2)
print(d // (24 * 3600)) --> 1123.0

myepoch = os.time({year=2000, month=1, day=1, hour=0})
now = os.time({year=2015, month=11, day=20})
print(os.difftime(now, myepoch)) -- 501336000.0