function Tick()
    if Input.KeyPressed("E") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
end

function SwitchGravity(character)
    character.gravityDirection = character.gravityDirection * -1
end