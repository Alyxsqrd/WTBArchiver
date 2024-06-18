function OnInteracted(character)
  while true do
    object.physics.AddForce(character.cameraDirection * 15)
    wait(2)
  end
end