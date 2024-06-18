

function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                if (wildcard.forceField) then
                    wildcard.forceField = false
                    printScreen("Force Field is OFF", 2)
                else
                    wildcard.forceField = true
                    printScreen("Force Field is ON", 2)
                end
            end
        end
    end
end