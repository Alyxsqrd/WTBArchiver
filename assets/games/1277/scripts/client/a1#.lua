function Tick()
    if Input.KeyPressed("C") then
        this.RunOnServer("OnTouchBegin", GetLocalCharacter())
    end
end

function OnTouchBegin(wildcard)
    object.sound.Play()
    character.gravityDirection = character.gravityDirection * -1
end