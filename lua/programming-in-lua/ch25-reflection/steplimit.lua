local debug = require "debug"

-- 最大能够执行的"steps"
local steplimit = 1000

local count = 0 -- 计数器

local function step ()
    count = count + 1
    if count > steplimit then
        error("script uses too much CPU")
    end
end

-- 加载
local f = assert(loadfile(arg[1], "t", {}))

debug.sethook(step, "", 100) -- 设置钩子
f() -- 运行文件