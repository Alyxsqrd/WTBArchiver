local appleLeaderstat = GetObjectByName("CollectedApples")

function OnInteracted(character)
    print('1')
    this.RunOnServer("GrantItem", wildcard)
    print('2')
    appleLeaderstat.worldText.text = appleLeaderstat.worldText.text + 1
end 
    
function GrantItem()
    print('3')
    GrantItemTo(object.name, GetLocalCharacter())
    DeleteObject(object)
print('4')
end

