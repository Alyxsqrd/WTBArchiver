function Tick()
    if Input.KeyHeld("t") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
end

function SwitchGravity(character)
    object.physics.AddForce(character.cameraDirection * 800)
end