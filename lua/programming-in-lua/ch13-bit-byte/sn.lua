s = string.pack("s1", "hello")
for i = 1, #s do
    print((string.unpack("B", s, i)))
end
-- 5    (length)
-- 104  ('h')
-- 101  ('e')
-- 108  ('l')
-- 108  ('l')
-- 111  ('l')