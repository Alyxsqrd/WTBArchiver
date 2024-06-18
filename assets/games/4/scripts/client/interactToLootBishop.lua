

function OnInteracted(myCharacter)
    print("wooper2")
    if not IsValid(myCharacter) then
        print("AHHHH1")
    end
    if isHost then
        local bish = GetObjectByName("Bishop")
        if IsValid(bish) then
            if IsItem(bish.item) then
                myCharacter.LootItem(bish.item)
                print("3 worked!")
            else
                print("2")
            end
        else
            print("1")
        end
    else
        print("not host")
    end
end