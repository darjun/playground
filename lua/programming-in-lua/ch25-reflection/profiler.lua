local Counters = {}
local Names = {}

local function hook ()
    local f = debug.getinfo(2, "f").func
    local count = Counters[f]
    if count == nil then -- 'f'第一次被调用？
        Counters[f] = 1
        Names[f] = debug.getinfo(2, "Sn")
    else -- 只需要递增计数器即可
        Counters[f] = Counters[f] + 1
    end
end

local f = assert(loadfile(arg[1]))
debug.sethook(hook, "c") -- 设置call事件的钩子
f() -- 运行主程序
debug.sethook() -- 关闭钩子

function getname (func)
    local n = Names[func]
    if n.what == "C" then
        return n.name
    end
    local lc = string.format("[%s]:%d", n.short_src, n.linedefined)
    if n.what ~= "main" and n.namewhat ~= "" then
        return string.format("%s (%s)", lc, n.name)
    else
        return lc
    end
end

for func, count in pairs(Counters) do
    print(getname(func), count)
end