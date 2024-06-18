function Tick()
    if(Input.KeyPressed("x"))then
        GetLocalCharacter().speed = 0.3
    elseif(Input.KeyReleased("x"))then
        GetLocalCharacter().speed = 1
    end
end