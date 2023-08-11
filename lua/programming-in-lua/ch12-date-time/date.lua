t = 906000490
-- ISO 8601 格式的日期
print(os.date("%Y-%m-%d", t))
  --> 1998-09-17

-- ISO 8601格式的日期和时间
print(os.date("%Y-%m-%dT%H:%M:%S", t))
  --> 1998-09-17T10:48:10

-- ISO 8601格式的序数日期
print(os.date("%Y-%j", t))
  --> 1998-260