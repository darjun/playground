local lpeg = require "lpeg"

-- matches a numeral and captures its numerical value
number = lpeg.R"09"^1 / tonumber

-- auxiliary function to add two numbers
function add (acc, newvalue) return acc + newvalue end

-- matches a list of numbers, adding their values
sum = number * ("," * number % add)^0

-- example of use
print(sum:match("10,30,43")) --> 83