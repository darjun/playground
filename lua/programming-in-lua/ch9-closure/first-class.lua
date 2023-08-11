a = {p = print}     -- 'a.p'指向'print'函数
a.p("Hello World")  -- Hello World
print = math.sin    -- 'print'现在指向sine函数
a.p(print(1))       -- 0.8414709848079
math.sin = a.p      -- 'sin'现在指向print函数
math.sin(10, 20)    -- 10   20