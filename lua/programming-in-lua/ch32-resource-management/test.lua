local dir = require "dir"

for d in dir.open("./") do
  print(d)
end