

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            if wildcard.HasItem("bishop") then
                print("HAS BISHOP!")
            else
                print("no bishop..")
            end

            if wildcard.HasItemEquipped("bishop") then
                print("HAS BISHOP EQUIPPED!")
            else
                print("bishop is not equipped")
            end
        end
    end
end