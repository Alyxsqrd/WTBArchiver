function Begin()
  while true do
    object.RotateTowards(character.position)
    object.physics.AddForce(object.forwardDirection * 30)
    wait(1)
  end
end