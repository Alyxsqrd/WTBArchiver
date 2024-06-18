function OnTouchBegin(wildcard)
    if isHost and IsCharacter(wildcard) then
        wildcard.gravityPower = 0.5
    end
end

function OnTouchEnd(wildcard)
    if isHost and IsCharacter(wildcard) then
        wildcard.gravityPower = 1
    end
end