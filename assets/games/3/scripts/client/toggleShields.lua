

function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                if (wildcard.maxShields > 0) then
                    wildcard.maxShields = 0
                    printScreen("Shields OFF", 2)
                else
                    wildcard.maxShields = 50
                    printScreen("Shields ON", 2)
                end
            end
        end
    end
end