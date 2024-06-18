function OnInteracted(character)
  while true do
    object.position = character.position
    object.rotation = character.rotation
    character.visible = false
    character.scale = 1
    character.speed = 2
    wait(0.0000001)
  end
end