local date = 1691759860
local day2year = 365.242            -- 1年的天数
local sec2hour = 60 * 60            -- 1小时的秒数
local sec2day = sec2hour * 24       -- 1天的秒数
local sec2year = sec2day * day2year -- 1年的秒数

-- 年
print(date // sec2year + 1970)      --

-- 小时（UTC格式）
print(date % sec2day // sec2hour)   --

-- 分钟
print(date % sec2hour // 60)        --

-- 秒
print(date % 60)                    -- 