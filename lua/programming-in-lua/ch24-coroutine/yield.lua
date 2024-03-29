co = coroutine.create(function ()
    for i = 1, 10 do
        print("co", i)
        coroutine.yield()
    end
end)

coroutine.resume(co) --> co 1

print(coroutine.status(co)) --> suspended

coroutine.resume(co) --> co 2
coroutine.resume(co) --> co 3
coroutine.resume(co) --> co 4
coroutine.resume(co) --> co 5
coroutine.resume(co) --> co 6
coroutine.resume(co) --> co 7
coroutine.resume(co) --> co 8
coroutine.resume(co) --> co 9
coroutine.resume(co) --> co 10
coroutine.resume(co) --> 不输出任何数据

print(coroutine.resume(co))
  --> false cannot resume dead coroutine