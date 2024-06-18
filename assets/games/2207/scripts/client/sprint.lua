

function Tick()
    local character = GetLocalCharacter()
    if Input.KeyPressed("LeftShift") then
        this.RunOnServer("SprintOn", character)
    end
    if Input.KeyReleased("LeftShift") then
        this.RunOnServer("SprintOff", character)
    end
end

function SprintOn(character)
    character.speed = 2
end

function SprintOff(character)
    character.speed = 1
end