local url = require "socket.url"

parsed_url = url.parse("http://www.example.com/cgilua/index.lua?a=2#there")
-- parsed_url = {
--   scheme = "http",
--   authority = "www.example.com",
--   path = "/cgilua/index.lua",
--   query = "a=2",
--   fragment = "there",
--   host = "www.example.com",
-- }

for field, value in pairs(parsed_url) do
  print(field, value)
end

parsed_url = url.parse("ftp://root:passwd@unsafe.org/pub/virus.exe;type=i")
-- parsed_url = {
--   scheme = "ftp",
--   authority = "root:passwd@unsafe.org",
--   path = "/pub/virus.exe",
--   params = "type=i",
--   userinfo = "root:passwd",
--   host = "unsafe.org",
--   user = "root",
--   password = "passwd",
-- }

for field, value in pairs(parsed_url) do
  print(field, value)
end
