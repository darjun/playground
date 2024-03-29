local Set = {}

local mt = {} -- 集合的元表

function Set.new (l)
    local set = {}
    setmetatable(set, mt)
    for _, v in pairs(l) do set[v] = true end
    return set
end

function Set.union (a, b)
    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
        error("attempt to 'add' a set with a non-set value", 2)
    end
    local res = Set.new{}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

function Set.intersection (a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.difference (a, b)
    local res = Set.new{}
    for k in pairs(a) do
        if not b[k] then
            res[k] = true
        end
    end
    return res
end

-- 将集合表示为字符串
function Set.tostring (set)
    local l = {} -- 保存集合中所有元素的列表
    for e in pairs(set) do
        l[#l+1] = tostring(e)
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

mt.__add = Set.union
mt.__mul = Set.intersection
mt.__sub = Set.difference

mt.__le = function (a, b) -- 子集
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end

mt.__lt = function (a, b) -- 真子集
    return a <= b and not (b <= a)
end

mt.__eq = function (a, b)
    return a <= b and b <= a
end

mt.__tostring = Set.tostring

-- mt.__metatable = "not your business"

s1 = Set.new{1,2,3}
s2 = Set.new{1,4}
print(s1 - s2)