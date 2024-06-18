local itemObtained = false
local itemName = "sus"

function OnInteracted(character)
  this.RunOnServer("ServerInteract", character)
end

function ServerInteract(character)
  if character.HasItem(itemName) then
    itemObtained = true
    print("string 1 through 5 is being run")
    object.voxelRenderer.visible = false
    object.collider.enabled = false
    object.sound.Play()
    object.interactable.enabled = false
    print("5 has been run, next is else.")
  else
    if itemObtained == false then
      print("I think Ill need the thing for this.")
    end
  end
end
