function OnTouchBegin(touched)
    newTeleporter = "Level"..tostring(tonumber(string.sub(object.name,1,1))+1).."Teleport"
    oldTeleporter = "Level"..string.sub(object.name,1,1).."Teleport"
    teleporter = GetObjectByName(oldTeleporter)
    if(teleporter != nil) then
        teleporter.name = newTeleporter
        door = GetObjectByName("Computer1Door")
        door.renderer.visible = true
        door.collider.enabled = true

        local openDoor = GetObjectByName("Computer1DoorOpen")
        openDoor.collider.enabled = false
        openDoor.renderer.visible = false

        Event.Broadcast("resetClicks")
    end
end