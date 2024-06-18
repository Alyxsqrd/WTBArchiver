function tick()
    GetLocalCharacter().cameraZoom = 0
    if(Input.KeyPressed("F"))then
        GetLocalCharacter().cameraZoom = 10.55
    elseif(Input.KeyReleased("F"))then
        GetLocalCharacter().cameraZoom = 0
    end
end