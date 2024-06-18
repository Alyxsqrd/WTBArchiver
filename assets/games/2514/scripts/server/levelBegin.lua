function OnTouchBegin(touched)
    newTeleporter = "Level"..tostring(tonumber(string.sub(object.name,1,1))+1).."Teleport"
    oldTeleporter = "Level"..string.sub(object.name,1,1).."Teleport"
    teleporter = GetObjectByName(oldTeleporter)
    if(teleporter != nil) then
        teleporter.name = newTeleporter
        door = GetObjectByName("Computer1Door")
        door.position = teleporter.position - Vector3.New(0.5,0,0)
        Event.Broadcast("resetClicks")
    end
end