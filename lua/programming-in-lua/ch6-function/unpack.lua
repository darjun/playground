print(table.unpack({10, 20, 30}))   --> 10  20  30
a, b = table.unpack{10, 20, 30}     --> 10  20

f = string.find
a = {"hello", "ll"}

print(f(table.unpack(a)))

print(table.unpack({"Sun", "Mon", "Tue", "Wed"}, 2, 3))
--> Mon  Tue
