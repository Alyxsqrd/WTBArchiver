function OnTouchBegin(wildcard)
    if isHost and IsCharacter(wildcard) then
        wildcard.gravityDirection = wildcard.gravityDirection * -0.5
    end
end