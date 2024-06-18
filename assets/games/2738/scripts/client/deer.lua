function OnInteracted(character)
  while true do
    object.position = character.position
    object.rotation = character.rotation
    character.visible = false
    character.speed = 0.9
    character.maxHealth = 0.9
    wait(0.00001)
  end
end