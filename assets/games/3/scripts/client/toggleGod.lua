

function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                if (wildcard.god) then
                    wildcard.god = false
                    printScreen("God is OFF", 2)
                else
                    wildcard.god = true
                    printScreen("God is ON", 2)
                end
            end
        end
    end
end