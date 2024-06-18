local itemObtained = false
local itemName = "Holiday Key"
local itemName2 = "Christmas Key"
local itemName3 = "Candy Key"

function OnInteracted(character)
  this.RunOnServer("ServerInteract", character)
end

function ServerInteract(character)
  if character.HasItem(itemName) and character.HasItem(itemName2) and character.HasItem(itemName3) then
    itemObtained = true
    print("string 1 through 5 is being run")
    character.RemoveItem(itemName)
    object.voxelRenderer.visible = false
    object.collider.enabled = false
    object.sound.Play()
    object.interactable.enabled = false
    print("5 has been run, next is else.")
  else
    if itemObtained == false then
      character.player.SendSystemChat("I think I'll need the Dark, Christmas and Candy Keys for this door.")
    end
  end
end
