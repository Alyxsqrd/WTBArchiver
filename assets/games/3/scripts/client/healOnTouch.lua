local healing = 50;


function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                printScreen("Heal "..healing.." health!", 2)
                wildcard.Heal(healing)
            end
        end
    end
end