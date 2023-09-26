function traceback ()
    for level = 1, math.huge do
        local info = debug.getinfo(level, "Sl")
        if not info then break end
        if info.what == "C" then -- 是否是C函数？
            print(string.format("%d\tC function", level))
        else -- Lua 函数
            print(string.format("%d\t[%s]:%d", level,
                info.short_src, info.currentline))
        end
    end
end

function f1 ()
    traceback()
end

function f2 ()
    f1()
end

function f3 ()
    f2()
end

f3()