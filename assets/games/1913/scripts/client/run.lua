function Tick()
    if(Input.KeyPressed("z"))then
        wait(2)
        GetLocalCharacter().speed = 2
    elseif(Input.KeyReleased("x"))then
        GetLocalCharacter().speed = 0.5
    end
end