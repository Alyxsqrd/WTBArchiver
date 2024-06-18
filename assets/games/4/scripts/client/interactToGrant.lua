

function OnInteracted(myCharacter)
    print("poopy1")
    if isHost then
        myCharacter.GrantItem("test item")
        print("done! granted!")
    else
        print("not host")
    end
end