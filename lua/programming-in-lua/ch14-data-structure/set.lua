function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

reversed = Set{"while", "end", "function", "local",}

local ids = {}
for w in string.gmatch(s, "[%a_][%w_]*") do
    if not reversed[w] then
        ids[w] = true
    end
end

-- 输出每一个标识符
for w in pairs(ids) do print(w) end
