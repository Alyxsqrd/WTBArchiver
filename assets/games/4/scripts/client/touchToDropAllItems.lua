

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            wildcard.DropAllItems()
        end
    end
end

function OnInteracted(myCharacter)
    if isHost then
        myCharacter.RemoveAllItems()
    end
end