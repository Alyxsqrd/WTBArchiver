local itemName = "Coin"

function OnInteracted(character)
this.RunOnServer("ServerInteract", character)
end

function ServerInteract(character)
if character.HasItem(itemName) then
character.RemoveItem(itemName)

object.collider.enabled = false
object.sound.Play()
end
end