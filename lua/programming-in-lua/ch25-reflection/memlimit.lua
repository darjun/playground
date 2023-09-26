-- 最大能够使用的内存（单位KB）
local memlimit = 1000

-- 最大能够执行的"step"
local steplimit = 1000

local function checkmem ()
    if collectgarbage("count") > memlimit then
        error("script uses too much memory")
    end
end

local count = 0
local function step ()
    checkmem()
    count = count + 1
    if count > steplimit then
        error("script uses too much CPU")
    end
end

-- 加载
local f = assert(loadfile(arg[1], "t", {}))

debug.sethook(step, "", 100) -- 设置钩子
f() -- 运行文件
