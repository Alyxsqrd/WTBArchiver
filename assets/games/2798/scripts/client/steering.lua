local rotating = false
local rotationSpeed = 0.0
local rotationAmount = 30

function Tick()
  if rotating == false then
    if Input.KeyPressed("E") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
    if Input.KeyReleased("E") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, -rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
    if Input.KeyPressed("Q") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, -rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
    if Input.KeyReleased("Q") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
  end
end