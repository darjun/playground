pair = "name = Anna"
key, value = string.match(pair, "(%a+)%s*=%s*(%a+)")
print(key, value) --> name Anna

date = "Today is 17/7/1990"
d, m, y = string.match(date, "(%d+)/(%d+)/(%d+)")
print(d, m, y) --> 17 7 1990

s = [[then he said: "it's all right"!]]
q, quotedPart = string.match(s, "([\"'])(.-)%1")
print(quotedPart) --> it's all right
print(q) --> "

p = "%[(=*)%[(.-)%]%1%]"
s = "a = [=[[[ something ]==] ]=]; print(a)"
print(string.match(s, p)) --> =     [[ something ]] ]==]

print((string.gsub("hello Lua!", "%a", "%0-%0")))
  --> h-he-el-ll-lo-o L-Lu-ua-a!

print((string.gsub("hello Lua", "(.)(.)", "%2%1")))
  --> ehll ouLa

s = [[the \quote{task} is to \em{change} that.]]
s = string.gsub(s, "\\(%a+){(.-)}", "<%1>%2<%1>")
print(s)
  -- the <quote>task<quote> is to <em>change<em> that.

function trim (s)
    s = string.gsub(s, "^%s*(.-)%s*$", "%1")
    return s
end

print(trim("     hello world   "))
  -- hello world
