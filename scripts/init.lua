thing = {"One fish", "Two fish", "Red fish", "Blue fish"}
for k, v in pairs(thing) do 
    print(k, v)
end

print("Length of thing[1] = " .. string.len(thing[1]))

--[[ Creates an error:
local x = nil;
print(x.y)
]]


--[[ Runable lua:



]]