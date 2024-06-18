local rotating = false
local rotationSpeed = 0.001
local rotationAmount = 1
function OnInteracted(character)
  while true do
    if rotating == false then
      if Input.KeyHeld("E") then
        rotating = true
        object.RotateAround(object.position, object.upDirection, rotationAmount, rotationSpeed)
        wait(0.2)
        rotating = false
      end
      if Input.KeyReleased("E") then
        rotating = false
        wait(0.1)
      end
      if Input.KeyHeld("Q") then
        rotating = true
        object.RotateAround(object.position, object.upDirection, -rotationAmount, rotationSpeed)
        wait(0.1)
        rotating = false
      end
      if Input.KeyReleased("Q") then
        rotating = false
        wait(0.1)
      end
      if Input.KeyHeld("W") then
        object.physics.AddForce(object.forwardDirection * 300)
      end
    end
  end
end