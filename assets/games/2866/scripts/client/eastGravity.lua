function OnTouchBegin(wildcard)
    if isHost and IsCharacter(wildcard) then
        wildcard.gravityDirection = Vector3.New(1, 0, 0)
    end
end