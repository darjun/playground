print "enter function to be plotted (with variable 'x'):"
local line = io.read()
local f = assert(load("return " .. line))
for i = 1, 20 do
    x = i -- 全局的'x'（当前代码段内可见）
    print(string.rep("*", f()))
end
