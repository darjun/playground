s = string.pack(">i4", 1000000)
for i = 1, #s do
    print((string.unpack("B", s, i)))
end
-- 0
-- 15
-- 66
-- 64