function OnInteracted(character)
  while true do
    object.physics.AddForce(character.cameraDirection * 8)
    object.light.color = Color.New(0, 0, 0)
    wait(1)
    object.light.color = Color.New(0, 0, 1)
    wait(0.5)
  end
end