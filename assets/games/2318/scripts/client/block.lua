function OnMouseClick()
    mousePos = Input.mouseWorldPosition
    relMousePos = object.position - mousePos
    local blockPos = object.position
    if relMousePos.x == 0.5 then
        blockPos = blockPos - Vector3.New(1,0,0)
    end
    if relMousePos.x == -0.5 then
        blockPos = blockPos + Vector3.New(1,0,0)
    end
    if relMousePos.y == 0.5 then
        blockPos = blockPos - Vector3.New(0,1,0)
    end
    if relMousePos.y == -0.5 then
        blockPos = blockPos + Vector3.New(0,1,0)
    end
    if relMousePos.z == 0.5 then
        blockPos = blockPos - Vector3.New(0,0,1)
    end
    if relMousePos.z == -0.5 then
        blockPos = blockPos + Vector3.New(0,0,1)
    end
    Event.BroadcastToServer("placeBlock",blockPos,object.id,GetLocalCharacter().netId)
end