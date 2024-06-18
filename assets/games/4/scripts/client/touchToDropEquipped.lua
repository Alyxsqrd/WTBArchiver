

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            wildcard.DropEquippedItem()
        end
    end
end

function OnInteracted(myCharacter)
    if isHost then
        myCharacter.RemoveEquippedItem()
    end
end