s = "some string"
words = {}
for w in string.gmatch(s, "%a+") do
    words[#words+1] = w
    print(w)
end