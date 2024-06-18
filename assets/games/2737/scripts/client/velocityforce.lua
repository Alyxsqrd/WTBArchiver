function OnInteracted(character)
  while true do
    object.physics.AddForce(character.cameraDirection * 15)
    wait(1)
  end
end