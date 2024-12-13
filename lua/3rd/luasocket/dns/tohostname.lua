local socket = require "socket"
local dns = socket.dns

local ip, t = dns.tohostname("127.0.0.1")

print(ip, t)
