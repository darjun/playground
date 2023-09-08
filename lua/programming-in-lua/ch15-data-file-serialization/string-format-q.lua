a = 'a "problematic" \\string'
print(string.format("%q", a))
-- "a \"problematic\" \\string"