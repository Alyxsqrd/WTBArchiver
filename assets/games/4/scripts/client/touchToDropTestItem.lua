

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            wildcard.DropItem("test ITEM")
        end
    end
end

function OnInteracted(myCharacter)
    if isHost then
        myCharacter.RemoveItem("TEST iteM")
    end
end