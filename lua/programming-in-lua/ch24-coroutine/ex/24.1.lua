function receive ()
    local value = coroutine.yield()
    return value
end

function send (x)
    coroutine.resume(consumer, x)
end

function producer ()
    while true do
        local x = io.read() -- 产生新值
        send(x) -- 发给消费者
    end
end

function consumer (x)
    while true do
        io.write(x, "\n") -- 消费
        x = receive() -- 接收来自生产者的值
    end
end

consumer = coroutine.create(consumer)

producer()