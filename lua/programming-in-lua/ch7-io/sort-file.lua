local lines = {}

-- 将所有行读取到表'lines'中
for line in io.lines() do
    lines[#lines+1] = line
end

-- 排序
table.sort(lines)

-- 输出所有的行
for _, l in ipairs(lines) do
    io.write(l, "\n")
end
