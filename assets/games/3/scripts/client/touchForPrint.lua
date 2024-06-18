

function OnTouchBegin(wildcard)
    if IsValid(wildcard) then
        if IsCharacter(wildcard) then
            printScreen("Touched!", 2)
        end
    end
end