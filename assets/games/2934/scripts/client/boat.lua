function OnInteracted(character)
  if true do
    if Input.KeyHeld("W") then
        object.physics.AddForce(object.forwardDirection * 600)
        wait(2)
      end
    end
  end
end