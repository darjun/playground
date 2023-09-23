co = coroutine.create(function ()
    print("hi")
end)
print(type(co)) --> thread
print(coroutine.status(co))

coroutine.resume(co)

print(coroutine.status(co))