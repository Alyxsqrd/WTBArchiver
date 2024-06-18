function Tick()
    local mouseDown = Input.LeftMousePressed()
    if(mouseDown) then
        local player = GetLocalCharacter()
        Event.BroadcastToServer("shoot", 0, player.position.x, player.position.z, player.rotation.y, player.forwardDirection)
    end
end