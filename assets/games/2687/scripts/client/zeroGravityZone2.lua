function OnTouchBegin(wildcard)
    if isHost and IsCharacter(wildcard) then
        wildcard.gravityPower = 60
    end
end

function OnTouchEnd(wildcard)
    if isHost and IsCharacter(wildcard) then
        wildcard.gravityPower = 1
    end
end