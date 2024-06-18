

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        wildcard.gravityDirection = Vector3.New(0, 0, -1)
    end
end