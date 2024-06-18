function Tick()
    if Input.KeyHeld("W") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
end

function SwitchGravity(character)
    object.physics.AddForce(-object.forwardDirection * 600)
end