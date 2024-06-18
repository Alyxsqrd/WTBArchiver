

local originalColor = object.renderer.color
local cooldownColor = object.renderer.color


function Begin()
    object.netTable["used"] = false

    if originalColor == Color.ColorFromHex("#ffffff") then
        cooldownColor = Color.ColorFromHex("#c1c1c1")
    else
        cooldownColor = Color.ColorFromHex("#494949")
    end

    OnNetTableUpdated() -- update for good measure
end

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            if not object.netTable["used"] then
                object.sound.Play()
                object.netTable["used"] = true
                wait(1)
                object.netTable["used"] = false
            end
        end
    end
end

function OnNetTableUpdated()
    if object.netTable["used"] then
        if isHost then
            object.renderer.color = cooldownColor
        end
    else
        if isHost then
            object.renderer.color = originalColor
        end
    end
end