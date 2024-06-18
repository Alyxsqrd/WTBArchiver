local rotating = false
local rotationSpeed = 0.001
local rotationAmount = 2
function Tick()
  if rotating == false then
    if Input.KeyHeld("Y") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, rotationAmount, rotationSpeed)
      wait(0.2)
      rotating = false
    end
    if Input.KeyReleased("Y") then
      rotating = false
      wait(0.2)
    end
    if Input.KeyHeld("R") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, -rotationAmount, rotationSpeed)
      wait(0.2)
      rotating = false
    end
    if Input.KeyReleased("R") then
      rotating = false
      wait(0.2)
    end
    if Input.KeyHeld("T") then
      object.physics.AddForce(object.forwardDirection * 30)
    end
  end
end