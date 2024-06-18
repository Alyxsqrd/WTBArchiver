function OnInteracted(character)
    print('1')
    if GetPlayerByUsername("Paperr") then 
        this.RunOnServer("GrantItem", wildcard)
    end 
    print('2')
end 
    
function GrantItem()
    print('3')
    GrantItemTo(object.name, GetLocalCharacter())
    DeleteObject(object)
print('4')
end