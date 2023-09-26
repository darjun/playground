co = coroutine.create(function ()
    local x = 10
    coroutine.yield()
    error("some error")
end)

coroutine.resume(co)
print(debug.traceback(co))
print(coroutine.resume(co)) -- false   coroutine-traceback.lua:4: some error
print(debug.traceback(co))
print(debug.getlocal(co, 1, 1)) --> x 10