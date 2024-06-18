function Tick()
    if Input.KeyPressed("F") then
        this.RunOnServer("Character.Damage(100)", GetLocalCharacter())
    end
end

