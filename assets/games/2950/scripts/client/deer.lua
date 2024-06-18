function OnInteracted(character)
  while true do
    object.position = character.position
    object.rotation = character.rotation
    character.visible = false
    wait(0.00001)
  end
end