function Tick()
    if Input.KeyPressed("E") then
        this.RunOnServer("object.physics.gravity", GetLocalCharacter())
    end
end

function object.physics.gravity(character)
    character.object.physics.gravity = true
end