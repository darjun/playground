local socket = require "socket"
local dns = socket.dns

local ip, t = dns.toip("baidu.com")

print(ip)
print("ip addr list:")
for _, v in ipairs(t.ip) do
  print("", v)
end

print("alias list:")
for _, v in ipairs(t.alias) do
  print("", v)
end

print("canonic name:", t.name)
