

function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                if (wildcard.gravityDirection == Vector3.New(0, -1, 0)) then
                    wildcard.gravityDirection = Vector3.New(0, 1, 0)
                    printScreen("Gravity switched to UP")
                else
                    wildcard.gravityDirection = Vector3.New(0, -1, 0)
                    printScreen("Gravity switched to DOWN")
                end
            end
        end
    end
end