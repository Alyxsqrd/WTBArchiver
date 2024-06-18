local appleLeaderstat = object.parent.GetChildByName("CollectedApples")

function OnInteracted(character)
    this.RunOnServer("GrantItem", wildcard)
    appleLeaderstat.worldText.text = appleLeaderstat.worldText.text + 1
    end 
    
    function GrantItem()
    GrantItemTo(object.name, GetLocalCharacter())
    DeleteObject(object)
    end