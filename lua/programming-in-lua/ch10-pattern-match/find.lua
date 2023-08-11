s = "hello world"
i, j = string.find(s, "hello")
print(i, j) -- 1 5
print(string.sub(s, i, j)) -- hello
print(string.find(s, "world")) -- 7 11
i, j = string.find(s, "l")
print(i, j)
print(string.find(s, "lll")) -- nil
