function Begin()
    gears = 0
    Event.Bind(this,"foundGear")
    Event.Bind(this,"resetScrap")
end

function foundGear()
    gears = gears + 1
    SendSystemChatToAll("Collected "..tostring(gears).."/5 Time Scrap")
    if gears >= 5 then
        Event.Broadcast("allScrapCollected")
    end
end

function resetScrap()
    gears = 0
end