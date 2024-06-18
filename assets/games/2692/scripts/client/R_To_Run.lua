function Tick()
    if(Input.KeyPressed("R"))then
        GetLocalCharacter().speed = 1.5
    elseif(Input.KeyReleased("R"))then
        GetLocalCharacter().speed = 0.5
    end
end