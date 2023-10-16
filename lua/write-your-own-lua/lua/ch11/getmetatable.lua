print(getmetatable("foo")) -- table: 0x56190248bea0
print(getmetatable("bar")) -- table: 0x56190248bea0
print(getmetatable(nil)) -- nil
print(getmetatable(false)) -- nil
print(getmetatable(100)) -- nil
print(getmetatable({})) -- nil
print(getmetatable(print)) -- nil