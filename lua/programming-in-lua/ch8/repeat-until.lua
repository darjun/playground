-- 输出第一个非空的行
local line
repeat
    line = io.read()
until line ~= ""
print(line)

-- 使用Newton-Raphson法计算'x'的平方根
local sqr = x / 2
repeat
    sqr = (sqr + x/sqr) / 2
    local error = math.abs(sqr^2 - x)
until error < x/10000   -- 局部变量'error'此时仍然可见
