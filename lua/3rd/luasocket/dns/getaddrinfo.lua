local socket = require "socket"
local dns = socket.dns

local t = dns.getaddrinfo("110.242.68.66")

for i, v in ipairs(t) do
  print("address" .. i .. ":")
  print("family:", v.family)
  print("address:", v.addr)
end

local t = dns.getaddrinfo("baidu.com")

for i, v in ipairs(t) do
  print("address" .. i .. ":")
  print("family:", v.family)
  print("address:", v.addr)
end
