function OnInteracted(character)
  while true do
    character.position = object.position
    object.rotation = character.cameraDirection
    character.visible = false
    character.scale = 0.3
    character.speed = 1
    wait(0.001)
  end
end