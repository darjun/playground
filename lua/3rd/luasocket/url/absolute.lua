local url = require "socket.url"

local base = "http://a/b/c/d:p?q"
print(url.absolute(base, "g:h")) 	-- g:h
print(url.absolute(base, "g"))		-- http://a/b/c/g
print(url.absolute(base, "./g"))	-- http://a/b/c/g
print(url.absolute(base, "g/"))		-- http://a/b/c/g/
print(url.absolute(base, "/g"))		-- http://a/g
print(url.absolute(base, "//g"))	-- http://g
print(url.absolute(base, "?y"))		-- http://a/b/c/?y
print(url.absolute(base, "g?y"))	-- http://a/b/c/g?y
print(url.absolute(base, "#s"))		-- http://a/b/c/d:p?q#s
print(url.absolute(base, "g#s"))	-- http://a/b/c/g#s
print(url.absolute(base, "g?y#s"))	-- http://a/b/c/g?y#s
print(url.absolute(base, ";x"))		-- http://a/b/c/;x
print(url.absolute(base, "g;x"))	-- http://a/b/c/g;x
print(url.absolute(base, "g;x?y#s"))	-- http://a/b/c/g;x?y#s
print(url.absolute(base, "."))		-- http://a/b/c/
print(url.absolute(base, "./"))		-- http://a/b/c/
print(url.absolute(base, ".."))		-- http://a/b/
print(url.absolute(base, "../"))	-- http://a/b/
print(url.absolute(base, "../g"))	-- http://a/b/g
print(url.absolute(base, "../.."))	-- http://a/
print(url.absolute(base, "../../"))	-- http://a/
print(url.absolute(base, "../../g"))	-- http://a/g

