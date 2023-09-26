function debug1 ()
    while true do
        io.write("debug> ")
        local line = io.read()
        if line == "cont" then break end
        assert(load(line))()
    end
end

local a = 1
local b = 2
local c = a + b
debug1()

print("end")