function Tick()
    if(Input.KeyPressed("LeftShift"))then
        wait(1)
        GetLocalCharacter().speed = 1.5
    elseif(Input.KeyReleased("LeftShift"))then
        GetLocalCharacter().speed = 0.8
    end
end