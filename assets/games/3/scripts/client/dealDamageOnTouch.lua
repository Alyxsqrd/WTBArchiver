local damage = 23;


function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                printScreen("Dealing "..damage.." damage!", 2)
                wildcard.Damage(damage)
            end
        end
    end
end