
function Begin()
    
    print("started")
    water = 10
    print("started")
    while true do
        wait(1)
        timecount()
    end
end

function timecount()
    if water == 0 then
        
        NetMessageGlobalAll("kill", GetLocalCharacter())
        water = 100
    end
    water = water - 0.25
    print(water)
    

end    
