function foo0 () end                    -- 不返回结果
function foo1 () return "a" end         -- 返回1个结果
function foo2 () return "a", "b" end    -- 返回2个结果

x, y = foo2()           -- x="a", y="b"
x = foo2()              -- x="a", "b"被丢弃
x, y, z = 10, foo2()    -- x=10, y="a", z="b"

x, y = foo0()           -- x=nil, y=nil
x, y = foo1()           -- x="a", y=nil
x, y, z = foo2()        -- x="a", y="b", z=nil

x, y = foo2(), 20       -- x="a", y=20 ("b"被丢弃)
x, y = foo0(), 20, 30   -- x=nil, y=20 (30被丢弃)

print(foo0())           --> （没有结果）
print(foo1())           --> a
print(foo2())           --> a  b
print(foo2(), 1)        --> a  1
print(foo2() .. "x")    --> ax

t = {foo0()}            --> t = {} （一个空表）
t = {foo1()}            --> t = {"a"}
t = {foo2()}            --> t = {"a", "b"}

t = {foo0(), foo2(), 4} --> t[1] = nil, t[2] = "a", t[3] = 4

function foo (i)
    if i == 0 then return foo0()
    elseif i == 1 then return foo1()
    elseif i == 2 then return foo2()
    end
end

print(foo(1))   --> a
print(foo(2))   --> a  b
print(foo(0))   --> （无结果）
print(foo(3))   --> （无结果）

print((foo0())) --> nil
print((foo1())) --> a
print((foo2())) --> a