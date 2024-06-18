local itemName = "Item"

function OnInteracted(character)
this.RunOnServer("ServerInteract", character)
end

function ServerInteract(character)
character.GrantItem(itemName)
end
end