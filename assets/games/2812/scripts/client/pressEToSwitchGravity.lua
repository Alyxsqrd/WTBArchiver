function Tick()
    if Input.KeyHeld("W") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
end

function SwitchGravity(character)
    object.physics.AddForce(character.cameraDirection * 600)
    object.rotation = (character.cameraDirection)
end