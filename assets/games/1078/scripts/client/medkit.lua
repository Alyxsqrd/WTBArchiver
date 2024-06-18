local stat = GetObjectByName("Block")
function Begin()
    print("started")
end
function OnItemMouseDown()
    print("clicked")
    if stat.netTable["health"] <= 75 then
        
    end
end