function loadwithprefix (prefix, s, chunkname, mode, env)
    local prefixloaded = false
    local contentloaded = false
    return load(function ()
        if not prefixloaded then
            prefixloaded = true
            return prefix .. " "
        end

        if type(s) == "function" then
            return s()
        end

        if contentloaded then
            return nil
        end

        contentloaded = true
        return s
    end, chunkname or "=", mode or "bt", env)
end

local f, err = loadwithprefix ("return", "2 + 1")
print(err)
print(f())