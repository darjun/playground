function receive ()
    local status, value = coroutine.resume(producer)
    return value
end

function send (x)
    coroutine.yield(x)
end

function producer ()
    while true do
        local x = io.read() -- 产生新值
        send(x) -- 发给消费者
    end
end

function consumer ()
    while true do
        local x = receive() -- 接收来自生产者的值
        io.write(x, "\n") -- 消费
    end
end

producer = coroutine.create(producer)

consumer()