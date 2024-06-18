function Tick()
    if Input.KeyHeld("W") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
end

function SwitchGravity(character)
    object.physics.AddForce(Vector3.New(0, 15, 0))
end