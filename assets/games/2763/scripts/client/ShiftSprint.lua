function Tick()
    if(Input.KeyPressed("LeftShift"))then
        GetLocalCharacter().speed = 2
    elseif(Input.KeyReleased("LeftShift"))then
        GetLocalCharacter().speed = 1
    end
end