local pegasus = require 'pegasus'

local server = pegasus:new({
  port='9090',
  location='www',
})

server:start(function (request, response)
  print("path:", request:path())
  print("headers:")
  for k, v in pairs(request:headers()) do
    print(k, v)
  end
  print("method:", request:method())
  print("querystring:")
  for k, v in pairs(request.querystring) do
    print(k, v)
  end
end)
