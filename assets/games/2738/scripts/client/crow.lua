function OnInteracted(character)
  while true do
    object.position = character.position
    object.rotation = character.rotation
    character.visible = false
    character.scale = 0.5
    character.speed = 0.7
    character.maxHealth = 0.5
    wait(0.0000001)
  end
end