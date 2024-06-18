

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        wildcard.gravityDirection = Vector3.New(-1, 0, 0)
    end
end