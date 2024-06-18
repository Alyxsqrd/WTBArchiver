function Tick()
    local mouseDown = Input.LeftMousePressed()
    if(mouseDown) then
        print("Bang!")
        local character = GetLocalPlayer().character
        local raycast = RayCast(character.position, character.cameraDirection, 10)
        print(raycast.hitWildcard.name)
    end
end