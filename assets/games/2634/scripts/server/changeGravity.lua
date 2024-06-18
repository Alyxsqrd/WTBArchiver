

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        wildcard.gravityDirection = object.downDirection
    end
end