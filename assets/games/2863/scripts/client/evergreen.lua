function OnInteracted(character)
  while true do
    object.position = character.position
    character.visible = false
    character.scale = 3
    character.speed = 0.1
    character.alwaysHideNametag = true
    wait(0.0000001)
  end
end