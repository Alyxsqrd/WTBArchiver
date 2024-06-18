

function OnTouchBegin(wildcard)
    if (isHost) then
        if IsValid(wildcard) then
            if IsCharacter(wildcard) then
                if (object.name == "SmallScale") then
                    wildcard.scale = 0.5
                    printScreen("Size changed to half")
                elseif (object.name == "BigScale") then
                    wildcard.scale = 2
                    printScreen("Size changed to double")
                else
                    wildcard.scale = 1
                    printScreen("Size changed to normal")
                end
            end
        end
    end
end