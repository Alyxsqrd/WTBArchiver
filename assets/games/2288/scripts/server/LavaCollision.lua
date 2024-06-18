function OnTouchBegan(wildcard)
    if IsCharacter(wildcard) then
        wildcard.health = 0
    end
end