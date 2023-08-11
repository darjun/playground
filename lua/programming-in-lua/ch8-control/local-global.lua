x = 10
local i = 1         -- 对于代码段来说是局部的

while i <= x do
    local x = i * 2 -- 对于循环体来说是局部的
    print(x)        --> 2, 4, 6, 8, ...
    i = i + 1
end
if i > 20 then
    local x         -- 对于"then"来说是局部的
    x = 20
    print(x + 2)    -- （如果测试成功会输出22）
else
    print(x)        -- 10（全局的）
end

print(x)            -- 10（全局的）
