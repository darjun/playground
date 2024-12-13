local http = require "socket.http"
local ltn12 = require "ltn12"
local io = require "io"

http.request {
    url = "https://lunarmodules.github.io/luasocket/http.html",
    sink = ltn12.sink.file(io.stdout)
}

