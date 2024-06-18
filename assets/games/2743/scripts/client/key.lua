local itemName = "Key"

print("1")
function OnInteracted(character)
this.RunOnServer("ServerInteract", character)
end

print("2")
function ServerInteract(character)
if character.HasItem(itemName) then
character.RemoveItem(itemName)

object.collider.enabled = false
object.sound.Play()
print("4")
end
end