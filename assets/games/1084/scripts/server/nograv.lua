function OnTouchBegin(wildcard)
    if IsCharacter (wildcard) then
        wildcard.gravityPower = 0
    end
end
    
function OnTouchEnd(wildcard)
    if IsCharacter (wildcard) then
        wildcard.gravityPower = 1
    end
end