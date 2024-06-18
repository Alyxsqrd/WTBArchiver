function OnItemMouseDown()
    local direction = Vector3.Direction(GetLocalCharacter().position, Input.mouseWorldPosition)
    Event.BroadcastToServer("spawnEgg", GetLocalCharacter(), direction)
end