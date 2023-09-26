-- 最大能够执行的"step"
local steplimit = 1000

-- 设置授权的函数
local validfunc = {
    [string.upper] = true,
    [string.lower] = true,
    -- 其他授权的函数
}

local count = 0
local function hook (event)
    if event == "call" then
        local info = debug.getinfo(2, "fn")
        if not validfunc[info.func] then
            error("calling bad function: " .. (info.name or "?"))
        end
    end
    count = count + 1
    if count > steplimit then
        error("script uses too much CPU")
    end
end

-- 加载
local f = assert(loadfile(arg[1], "t", {}))

debug.sethook(hook, "", 100) -- 设置钩子

f() -- 运行代码段
