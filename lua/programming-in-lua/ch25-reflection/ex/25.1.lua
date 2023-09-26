function getvarvalue (co, name, level, isenv)
    local value
    local found = false

    level = (level or 1) + 1
    -- 尝试局部变量
    for i = 1, math.huge do
        local n, v = debug.getlocal(co, level, i)
        if not n then break end
        if n == name then
            value = v
            found = true
        end
    end

    if found then return "local", value end

    -- 尝试非局部变量
    local func = debug.getinfo(co, level, "f").func
    for i = 1, math.huge do
        local n, v = debug.getupvalue(func, i)
        if not n then break end
        if n == name then return "upvalue", v end
    end

    if isenv then return "noenv" end -- 避免循环

    -- 没找到；从环境中获取值
    local _, env = getvarvalue(co, "_ENV", level, true)
    if env then
        return "global", env[name]
    else -- 没有有效的 _ENV
        return "noenv"
    end
end