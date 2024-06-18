local rotating = false
local rotationSpeed = 3.0
local rotationAmount = 80

function Tick()
  if rotating == false then
    if Input.KeyHeld("E") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
    end
    if Input.KeyHeld("Q") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, -rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
  end
end