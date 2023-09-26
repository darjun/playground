local socket = require "socket.core"

host = "www.lua.org"
file = "/manual/5.3/manual.html"

c = assert(socket.connect(host, 80))

local request = string.format(
    "GET %s HTTP/1.0\r\nhost: %s\r\n\r\n", file, host)
c:send(request)

repeat
    local s, status, partial = c:receive(2^10)
    io.write(s or partial)
until status == "closed"

c:close()