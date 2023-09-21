local t = {__gc = function ()
    -- 'atexit'的代码位于此处
    print("finishing Lua program")
end}
setmetatable(t, t)
_G["*AA*"] = t