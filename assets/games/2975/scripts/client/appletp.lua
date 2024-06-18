local character = nil
local pos = nil
local isInitialized = false

function Begin()
    wait(2)
    character = GetLocalCharacter()
    pos = character.position
    print("debug3")
    isInitialized = true
end

function LateTick()
    if isInitialized then
        pos = character.position
        pos.y = pos.y + 2.5
        object.position = pos
    end
end