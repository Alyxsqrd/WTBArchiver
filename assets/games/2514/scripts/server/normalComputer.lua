function Begin()
    clickVar = 0
    connectedDoor = GetObjectByName(object.name.."Door")
    Event.Bind(this,"resetClicks")
end

function resetClicks()
    clickVar = 0
end

function OnInteracted()
    if(clickVar == 0) then
        SendSystemChatToAll("Happy New Year's Buddy!")
    elseif(clickVar == 1) then
        SendSystemChatToAll("I know we haven’t really kept in touch much this year, but here’s to 1993!")
    elseif(clickVar == 2) then
        SendSystemChatToAll("Are you doing okay?")
    elseif(clickVar == 3) then
        SendSystemChatToAll("...")
    elseif(clickVar >= 4) then
        SendSystemChatToAll("RUN")
        if(connectedDoor != nil) then
            connectedDoor.position = Vector3.New(-1000,-1000,-1000)
        end
    end
    clickVar = clickVar + 1
end