local pegasus = require 'pegasus'

local server = pegasus:new({
  port='9090',
  location='www',
})

server:start(function (request, response)
  response:addHeader("Cache-Control", "no-cache")
    :write("hello pegasus world!")
end)
