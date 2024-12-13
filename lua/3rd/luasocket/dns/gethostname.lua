local socket = require "socket"
local dns = socket.dns

print(dns.gethostname())
