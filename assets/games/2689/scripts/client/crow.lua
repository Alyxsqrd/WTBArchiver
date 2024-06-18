function OnInteracted(character)
  while true do
    object.position = character.position
    object.rotation = character.rotation
    character.visible = false
    character.scale = 0.5
    wait(0.00001)
  end
end