local x1, x2
do
    local a2 = 2*a
    local d = (b^2 - 4*a*c)^(1/2)
    x1 = (-b + d)/a2
    x2 = (-b - d)/a2
end                 -- 'a2'和'd'的范围在此结束
print(x1, x2)       -- 'x1'和'x2'仍在范围内
