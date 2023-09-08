local authors = {} -- 保存作者姓名的集合
function Entry (b) authors[b.author] = true end
dofile ("data2")
for name in pairs(authors) do print(name) end
